module UIExplorer exposing (app, renderStories, UI, UICategory)

{-|

Component Explorers and Style Guides have been around for a while now.
We don't build pages anymore but components that are assembled together to build Systems.

In the ELM world, components are just called views, and are defined as pure functions.
ELM UI Explorer takes advantage of the composability and the purity of ELM and offers a way to showcase
your views and their states in a single tool.

Inspired by [React Storybook](https://storybook.js.org/)

# UIExplorer
@docs app
@docs renderStories
@docs UI
@docs UICategory

-}

import Html exposing (Html)
import Html exposing (Html, aside, ul, li, a, span, text, div, section, h1, h2, node, article)
import Html.Attributes exposing (class, rel, href, classList)
import Html.Events exposing (onClick)
import Elegant exposing (..)
import Color exposing (..)
import Navigation
import Array
import Color exposing (..)
import Color.Convert as ColorConvert


{--Messages --}


type Msg
    = Noop
    | SelectStory String
    | UrlChange Navigation.Location
    | NavigateToHome



{--Model --}


{-| A UI represents a view and lists a set of stories
-}
type alias UI =
    { id : String
    , description : String
    , viewStories : UIViewConfig -> Html Msg
    }


{-| Represents a familly of related views. For example using Atomic Design, we can have the following categories (Atoms, Molecules etc..)
-}
type alias UICategory =
    ( String, List UI )


type alias UIViewConfig =
    { selectedUIId : Maybe String
    , selectedStoryId : Maybe String
    }


{-| Model of the storybook
-}
type alias Model =
    { categories : List UICategory
    , selectedUIId : Maybe String
    , selectedStoryId : Maybe String
    , selectedCategory : Maybe String
    , history : List Navigation.Location
    }


getSelectedCategoryfromPath : Navigation.Location -> Maybe String
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


getSelectedUIfromPath : Navigation.Location -> Maybe String
getSelectedUIfromPath location =
    location.hash
        |> String.split "/"
        |> Array.fromList
        |> Array.get (1)


getSelectedStoryfromPath : Navigation.Location -> Maybe String
getSelectedStoryfromPath location =
    location.hash
        |> String.split "/"
        |> Array.fromList
        |> Array.get (2)


makeStateUrl : Model -> String -> Maybe String
makeStateUrl model stateId =
    Maybe.map2
        (\categoryId storyId ->
            [ categoryId, storyId, stateId ]
                |> String.join "/"
                |> (++) "#"
        )
        model.selectedCategory
        model.selectedUIId


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        SelectStory stateId ->
            case makeStateUrl model stateId of
                Just url ->
                    ( model, Navigation.newUrl url )

                Nothing ->
                    ( model, Cmd.none )

        UrlChange location ->
            ( { model
                | history = location :: model.history
                , selectedUIId = getSelectedUIfromPath location
                , selectedStoryId = getSelectedStoryfromPath location
                , selectedCategory = getSelectedCategoryfromPath location
              }
            , Cmd.none
            )

        NavigateToHome ->
            ( model, Navigation.newUrl "#" )


{-| Launches a UIExplorer Applicaton given a list of categories
-}
app : List UICategory -> Program Never Model Msg
app categories =
    Navigation.program UrlChange
        { init =
            (\location ->
                ( { categories = categories
                  , selectedUIId = getSelectedUIfromPath location
                  , selectedStoryId = getSelectedStoryfromPath location
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


hexToColor color =
    case ColorConvert.hexToColor color of
        Ok c ->
            c

        Err c ->
            white


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
            [ margin (Px sizes.storyContentPadding), width (Px 370) ]
    }


viewSidebar : Model -> Html Msg
viewSidebar model =
    let
        viewConfig =
            { selectedStoryId = model.selectedStoryId
            , selectedUIId = model.selectedUIId
            }
    in
        div [ class "column" ]
            [ div
                []
                []
            , viewMenu model.categories viewConfig
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
                    [ text "UI Explorer" ]
                ]
            ]
        ]


viewMenuItem : String -> Maybe String -> UI -> Html Msg
viewMenuItem category selectedUIId ui =
    let
        isSelected =
            case selectedUIId of
                Just id ->
                    id == ui.id

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
                , href ("#" ++ category ++ "/" ++ ui.id)
                , styles.sidebarItemLink
                ]
                [ text ui.id ]
            ]


viewMenuCategory : UIViewConfig -> UICategory -> Html Msg
viewMenuCategory { selectedUIId, selectedStoryId } ( title, categories ) =
    div []
        [ a
            [ class "menu-label", styles.sidebarItemCategory ]
            [ text ("> " ++ title) ]
        , ul [ class "menu-list" ]
            (List.map (viewMenuItem title selectedUIId) categories)
        ]


viewMenu : List UICategory -> UIViewConfig -> Html Msg
viewMenu categories config =
    aside [ class "menu", style [ marginTop (Px 0) ] ]
        (List.map (viewMenuCategory config) categories)


filterSelectedUI : UI -> Model -> Bool
filterSelectedUI ui model =
    Maybe.map (\id -> ui.id == id) model.selectedUIId
        |> Maybe.withDefault False


viewContent : Model -> Html Msg
viewContent model =
    let
        filteredUIs =
            model.categories
                |> List.map Tuple.second
                |> List.foldr (++) []
                |> List.filter (\ui -> filterSelectedUI ui model)

        viewConfig =
            { selectedStoryId = model.selectedStoryId
            , selectedUIId = model.selectedUIId
            }
    in
        div []
            [ filteredUIs
                |> List.map (\s -> s.viewStories viewConfig)
                |> List.head
                |> Maybe.withDefault
                    (div [ styles.welcome ]
                        [ span [ class "subtitle is-4 has-text-grey" ] [ text "We’re not designing pages, we’re designing systems of components." ]
                        , span [ class "subtitle is-5" ] [ text "—Stephen Hay" ]
                        ]
                    )
            , article []
                (filteredUIs
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


renderStory : Int -> UIViewConfig -> ( String, a ) -> Html Msg
renderStory index { selectedStoryId } ( id, state ) =
    let
        isActive =
            Maybe.map (\theId -> id == theId) selectedStoryId
                |> Maybe.withDefault (index == 0)

        buttonClass =
            classList [ ( "button", True ), ( "is-primary", isActive ) ]
    in
        li [ styles.stateButton, onClick <| SelectStory id, buttonClass ] [ text id ]


{-| Renders Stories of a given UI.
A story represents a state of a view such as (Loading, Error, Success, NoNetwork ...)
-}
renderStories : UIViewConfig -> (a -> Html msg) -> List ( String, a ) -> Html Msg
renderStories config storyView stories =
    let
        { selectedStoryId } =
            config

        menu =
            ul [ styles.stateNavigation ] (List.indexedMap (\index -> renderStory index config) stories)

        currentStories =
            case selectedStoryId of
                Just selectedId ->
                    List.filter (\( id, state ) -> id == selectedId) stories

                Nothing ->
                    stories

        content =
            case currentStories |> List.head of
                Just ( id, story ) ->
                    storyView story |> Html.map (\_ -> Noop)

                Nothing ->
                    text "Include somes states in your story..."
    in
        div []
            [ menu
            , div [ styles.storyContent ] [ content ]
            ]
