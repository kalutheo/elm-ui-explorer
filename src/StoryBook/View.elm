module StoryBook.View exposing (..)

import Html exposing (Html, aside, ul, li, a, text, div, section, h1, h2, node)
import Html.Attributes exposing (class, rel, href, classList)
import Html.Events exposing (onClick)
import StoryBook.Model exposing (..)
import Storybook.Msg exposing (..)
import Elegant exposing (..)
import Color exposing (..)


sizes =
    { commonMargin = 40
    , headerHeight = 100
    , headerMargin = 20
    , stateNavigationMargin = 20
    , stateButtonsMargin = 10
    , sidebarWidth = 200
    , storyContentPadding = 10
    }


colors =
    { neutral = gray
    }


styles =
    { logo = style [ paddingLeft (Px sizes.commonMargin) ]
    , sidebar =
        style
            [ width (Px sizes.sidebarWidth)
            , top (Px 0)
            , left (Px 0)
            , bottom (Px 0)
            , zIndex -1
            , backgroundColor colors.neutral
            , positionAbsolute
            ]
    , sidebarItem = style [ width (Px sizes.sidebarWidth) ]
    , sidebarItemLink = style [ paddingLeft (Px sizes.commonMargin) ]
    , stateNavigation = style [ margin (Px sizes.stateNavigationMargin) ]
    , stateButton = style [ marginRight (Px sizes.stateButtonsMargin) ]
    , storyContent = style [ paddingLeft (Px sizes.storyContentPadding) ]
    , header =
        style
            [ height (Px sizes.headerHeight)
            , paddingTop (Px sizes.headerMargin)
            , borderBottomSolid
            , borderBottomWidth 1
            , borderBottomColor white
            ]
    }


viewSidebar : Model Msg -> Html Msg
viewSidebar model =
    div [ class "column" ]
        [ div
            [ styles.sidebar
            ]
            []
        , viewMenu model.stories model.selectedStoryId
        ]


viewHeader : Html msg
viewHeader =
    section
        [ class "hero is-primary"
        , styles.header
        ]
        [ div []
            [ div [ styles.logo ]
                [ h1 [ class "title" ]
                    [ text "ELM" ]
                , h2 [ class "subtitle" ]
                    [ text "Storybook" ]
                ]
            ]
        ]


viewMenuItem : Maybe String -> Story Msg -> Html Msg
viewMenuItem selectedStoryId story =
    let
        isSelected =
            case selectedStoryId of
                Just id ->
                    id == story.id

                Nothing ->
                    False

        linkClass =
            if isSelected then
                "is-active"
            else
                ""
    in
        li [ styles.sidebarItem ]
            [ a [ class linkClass, onClick (SelectStory story.id), styles.sidebarItemLink ]
                [ text story.id ]
            ]


viewMenu : Stories Msg -> Maybe String -> Html Msg
viewMenu stories selectedStoryId =
    aside [ class "menu", style [ marginTop (Px 0) ] ]
        [ ul [ class "menu-list" ]
            (List.map (viewMenuItem selectedStoryId) stories)
        ]


filterSelectedStory : Story Msg -> Model Msg -> Bool
filterSelectedStory story model =
    Maybe.map (\id -> story.id == id) model.selectedStoryId
        |> Maybe.withDefault False


viewContent : Model Msg -> Html Msg
viewContent model =
    model.stories
        |> List.filter (\story -> filterSelectedStory story model)
        |> List.map (\s -> s.view model.selectedStateId)
        |> List.head
        |> Maybe.withDefault (div [] [ text "A simple storybook POC in ELM" ])


view : Model Msg -> Html Msg
view model =
    div []
        [ viewHeader
        , div [ class "columns is-mobile" ]
            [ viewSidebar model
            , div [ class "column is-three-quarters" ]
                [ viewContent model
                ]
            ]
        ]


renderState index selectedStateId ( id, state ) =
    let
        isActive =
            Maybe.map (\theId -> id == theId) selectedStateId
                |> Maybe.withDefault (index == 0)

        buttonClass =
            classList [ ( "button", True ), ( "is-primary", isActive ) ]
    in
        li [ styles.stateButton, onClick (SelectState id), buttonClass ] [ text id ]


renderStory selectedStateId storyView storyStates toMap wrapper =
    let
        menu =
            ul [ styles.stateNavigation ] (List.indexedMap (\index -> renderState index selectedStateId) storyStates)

        currentStates =
            case selectedStateId of
                Just selectedId ->
                    List.filter (\( id, state ) -> id == selectedId) storyStates

                Nothing ->
                    storyStates

        content =
            case currentStates |> List.head of
                Just ( id, state ) ->
                    Html.map toMap (storyView state) |> wrapper

                Nothing ->
                    text "Include somes states in your story..."
    in
        div [] [ menu, div [ styles.storyContent ] [ content ] ]
