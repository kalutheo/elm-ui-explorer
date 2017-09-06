module StoryBook exposing (storybook, renderStory, Story)

{-|

This library helps you create a simple storybook

# Storybook
@docs storybook
@docs renderStory
@docs Story
-}

import Html exposing (Html)
import Html exposing (Html, aside, ul, li, a, text, div, section, h1, h2, node, article)
import Html.Attributes exposing (class, rel, href, classList)
import Html.Events exposing (onClick)
import Elegant exposing (..)
import Color exposing (..)
import Atom.System exposing (hexToColor)


{--Messages --}


type Msg
    = Noop
    | SelectStory String
    | SelectState String



{--Model --}


{-| Item used to describe a Story
-}
type alias Story =
    { id : String
    , description : String
    , view : Maybe String -> Html Msg
    }


type alias StoryCategory =
    ( String, List Story )


type alias StoryCollection =
    List StoryCategory


{-| Model of the storybook
-}
type alias Model =
    { stories : StoryCollection
    , selectedStoryId : Maybe String
    , selectedStateId : Maybe String
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Noop ->
            model

        SelectState stateId ->
            { model | selectedStateId = Just stateId }

        SelectStory storyId ->
            { model | selectedStoryId = Just storyId, selectedStateId = Nothing }


{-| Generates a storybook Applicaton
    storybook stories
-}
storybook : StoryCollection -> Program Never Model Msg
storybook stories =
    let
        model =
            { stories = stories
            , selectedStoryId = Nothing
            , selectedStateId = Nothing
            }
    in
        Html.beginnerProgram
            { model = model
            , view = view
            , update = update
            }



{--VIEW --}


sizes =
    { commonMargin = 40
    , headerHeight = 100
    , headerMargin = 20
    , stateNavigationMargin = 20
    , stateButtonsMargin = 10
    , sidebarWidth = 200
    , storyContentPadding = 10
    , categoryPadding = 15
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
    , sidebarItemCategory =
        style
            [ width (Px sizes.sidebarWidth)
            , backgroundColor (hexToColor "#1d8a7a")
            , borderBottomSolid
            , borderBottomWidth 1
            , borderBottomColor (hexToColor "#FFF")
            , textColor (hexToColor "#FFF")
            , width (Px sizes.sidebarWidth)
            , displayFlex
            , height (Px 40)
            , lineHeight (Px 38)
            , marginBottom (Px 0)
            , paddingLeft (Px sizes.categoryPadding)
            ]
    , sidebarItemLink = style [ paddingLeft (Px sizes.commonMargin) ]
    , stateNavigation = style [ margin (Px sizes.stateNavigationMargin), marginLeft (Px sizes.stateButtonsMargin) ]
    , stateButton = style [ marginRight (Px sizes.stateButtonsMargin) ]
    , storyContent = style [ paddingLeft (Px sizes.storyContentPadding) ]
    , welcome = style [ paddingTop (Px sizes.welcomePadding) ]
    , header =
        style
            [ height (Px sizes.headerHeight)
            , paddingTop (Px sizes.headerMargin)
            , borderBottomSolid
            , borderBottomWidth 1
            , borderBottomColor white
            ]
    , welcome =
        style
            [ margin (Px sizes.storyContentPadding) ]
    }


viewSidebar : Model -> Html Msg
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


viewMenuItem : Maybe String -> Story -> Html Msg
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


viewMenuCategory : Maybe String -> StoryCategory -> Html Msg
viewMenuCategory selectedStoryId ( title, stories ) =
    div []
        [ a
            [ class "menu-label", styles.sidebarItemCategory ]
            [ text ("> " ++ title) ]
        , ul [ class "menu-list" ]
            (List.map (viewMenuItem selectedStoryId) stories)
        ]


viewMenu : StoryCollection -> Maybe String -> Html Msg
viewMenu storyCollection selectedStoryId =
    aside [ class "menu", style [ marginTop (Px 0) ] ]
        (List.map (viewMenuCategory selectedStoryId) storyCollection)


filterSelectedStory : Story -> Model -> Bool
filterSelectedStory story model =
    Maybe.map (\id -> story.id == id) model.selectedStoryId
        |> Maybe.withDefault False


viewContent : Model -> Html Msg
viewContent model =
    let
        filteredStories =
            model.stories
                |> List.map Tuple.second
                |> List.foldr (++) []
                |> List.filter (\story -> filterSelectedStory story model)
    in
        div []
            [ filteredStories
                |> List.map (\s -> s.view model.selectedStateId)
                |> List.head
                |> Maybe.withDefault (div [ styles.welcome ] [ text "A simple storybook POC in ELM" ])
            , article []
                (filteredStories
                    |> List.map (\s -> div [ styles.description ] [ text s.description ])
                )
            ]


view : Model -> Html Msg
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


{-| Renders a Story
-}
renderStory : Maybe String -> (a -> Html msg) -> List ( String, a ) -> Html Msg
renderStory selectedStateId storyView storyStates =
    let
        wrapper children =
            div [] [ children ]

        toMap =
            (\_ -> Noop)

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
        div []
            [ menu
            , div [ styles.storyContent ] [ content ]
            ]
