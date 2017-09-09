module StoryBook exposing (storybook, renderStory, Story)

{-|

This library helps you create a simple storybook

# Storybook
@docs storybook
@docs renderStory
@docs Story
-}

import Html exposing (Html)
import Html exposing (Html, aside, ul, li, a, span, text, div, section, h1, h2, node, article)
import Html.Attributes exposing (class, rel, href, classList)
import Html.Events exposing (onClick)
import Elegant exposing (..)
import Color exposing (..)
import Atom.System exposing (hexToColor)
import Navigation
import Array


{--Messages --}


type Msg
    = Noop
    | SelectState String
    | UrlChange Navigation.Location
    | NavigateToHome



{--Model --}


{-| Item used to describe a Story
-}
type alias Story =
    { id : String
    , description : String
    , view : StoryViewConfig -> Html Msg
    }


type alias StoryCategory =
    ( String, List Story )


type alias StoryCollection =
    List StoryCategory


{-| Model of the storybook
-}
type alias StoryViewConfig =
    { selectedStoryId : Maybe String
    , selectedStateId : Maybe String
    }


type alias Model =
    { stories : StoryCollection
    , selectedStoryId : Maybe String
    , selectedStateId : Maybe String
    , selectedCategory : Maybe String
    , history : List Navigation.Location
    }


getSelectedCategoryfromPath location =
    let
        removeHash =
            List.map (\s -> s |> String.slice 1 (s |> String.length))
    in
        location.hash
            |> String.split "/"
            |> removeHash
            |> Array.fromList
            |> Array.get (0)


getSelectedStoryfromPath location =
    location.hash
        |> String.split "/"
        |> Array.fromList
        |> Array.get (1)


getSelectedStatefromPath location =
    location.hash
        |> String.split "/"
        |> Array.fromList
        |> Array.get (2)


makeStateUrl model stateId =
    Maybe.map2
        (\categoryId storyId ->
            [ categoryId, storyId, stateId ]
                |> String.join "/"
                |> (++) "#"
        )
        model.selectedCategory
        model.selectedStoryId


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        SelectState stateId ->
            case makeStateUrl model stateId of
                Just url ->
                    ( model, Navigation.newUrl url )

                Nothing ->
                    ( model, Cmd.none )

        UrlChange location ->
            ( { model
                | history = location :: model.history
                , selectedStoryId = getSelectedStoryfromPath location
                , selectedStateId = getSelectedStatefromPath location
                , selectedCategory = getSelectedCategoryfromPath location
              }
            , Cmd.none
            )

        NavigateToHome ->
            ( model, Navigation.newUrl "#" )


{-| Generates a storybook Applicaton
    storybook stories
-}
storybook : StoryCollection -> Program Never Model Msg
storybook stories =
    Navigation.program UrlChange
        { init =
            (\location ->
                ( { stories = stories
                  , selectedStoryId = getSelectedStoryfromPath location
                  , selectedStateId = getSelectedStatefromPath location
                  , selectedCategory = getSelectedCategoryfromPath location
                  , history = [ location ]
                  }
                , Cmd.none
                )
            )
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
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
            , borderBottomSolid
            , borderBottomWidth 1
            , borderBottomColor (hexToColor "#999")
            , textColor (hexToColor "#222")
            , width (Px sizes.sidebarWidth)
            , displayFlex
            , height (Px 40)
            , lineHeight (Px 38)
            , marginBottom (Px 0)
            , paddingLeft (Px sizes.categoryPadding)
            ]
    , sidebarItemLink =
        style
            [ paddingLeft (Px sizes.commonMargin)
            , textColor (hexToColor "#666")
            ]
    , stateNavigation =
        style
            [ margin (Px sizes.stateNavigationMargin)
            , marginLeft (Px sizes.stateButtonsMargin)
            ]
    , stateButton = style [ marginRight (Px sizes.stateButtonsMargin) ]
    , storyContent = style [ paddingLeft (Px sizes.storyContentPadding) ]
    , description =
        style
            [ margin (Px sizes.storyContentPadding)
            , paddingTop (Px sizes.storyContentPadding)
            , marginTop (Px (sizes.storyContentPadding * 4))
            , borderTopSolid
            , borderTopWidth 1
            , borderTopColor gray
            ]
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
    let
        viewConfig =
            { selectedStateId = model.selectedStateId
            , selectedStoryId = model.selectedStoryId
            }
    in
        div [ class "column" ]
            [ div
                [ styles.sidebar
                ]
                []
            , viewMenu model.stories viewConfig
            ]


viewHeader : Html Msg
viewHeader =
    section
        [ class "hero is-primary"
        , styles.header
        ]
        [ div [ onClick NavigateToHome ]
            [ div [ styles.logo ]
                [ h1 [ class "title" ]
                    [ text "ELM" ]
                , h2 [ class "subtitle" ]
                    [ text "Storybook" ]
                ]
            ]
        ]


viewMenuItem : String -> Maybe String -> Story -> Html Msg
viewMenuItem category selectedStoryId story =
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
            [ a
                [ class linkClass
                , href ("#" ++ category ++ "/" ++ story.id)
                , styles.sidebarItemLink
                ]
                [ text story.id ]
            ]


viewMenuCategory : StoryViewConfig -> StoryCategory -> Html Msg
viewMenuCategory { selectedStoryId, selectedStateId } ( title, stories ) =
    div []
        [ a
            [ class "menu-label", styles.sidebarItemCategory ]
            [ text ("> " ++ title) ]
        , ul [ class "menu-list" ]
            (List.map (viewMenuItem title selectedStoryId) stories)
        ]


viewMenu : StoryCollection -> StoryViewConfig -> Html Msg
viewMenu storyCollection storyViewConfig =
    aside [ class "menu", style [ marginTop (Px 0) ] ]
        (List.map (viewMenuCategory storyViewConfig) storyCollection)


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

        viewConfig =
            { selectedStateId = model.selectedStateId
            , selectedStoryId = model.selectedStoryId
            }
    in
        div []
            [ filteredStories
                |> List.map (\s -> s.view viewConfig)
                |> List.head
                |> Maybe.withDefault
                    (div [ styles.welcome ]
                        [ span [ class "subtitle is-4" ] [ text "We’re not designing pages, we’re designing systems of components." ]
                        , span [ class "subtitle is-5" ] [ text "—Stephen Hay" ]
                        ]
                    )
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


renderState index { selectedStateId } ( id, state ) =
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
renderStory : StoryViewConfig -> (a -> Html msg) -> List ( String, a ) -> Html Msg
renderStory storyViewConfig storyView storyStates =
    let
        { selectedStateId } =
            storyViewConfig

        wrapper children =
            div [] [ children ]

        toMap =
            (\_ -> Noop)

        menu =
            ul [ styles.stateNavigation ] (List.indexedMap (\index -> renderState index storyViewConfig) storyStates)

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
