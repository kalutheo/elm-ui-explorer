module UIExplorer exposing (app, renderStories, UI, UICategory, addUICategory, emptyUICategories)

{-|

[Component Explorers](https://blog.hichroma.com/the-crucial-tool-for-modern-frontend-engineers-fb849b06187a) and [Style Guides](http://styleguides.io/) have been around for a while now.
We don't build pages anymore but components that are assembled together to build systems.

In the ELM world, components are just called views, and are defined as pure functions.
ELM UI Explorer takes advantage of the composability and the purity of ELM and offers a way to showcase
your views and their states in a single tool.

Inspired by [React Storybook](https://storybook.js.org/)

# UIExplorer
@docs app
@docs renderStories

# Models

@docs UI
@docs UICategory

# Utils
@docs addUICategory
@docs emptyUICategories
-}

import Html exposing (Html)
import Html exposing (Html, aside, ul, li, a, span, text, div, section, h1, h2, node, article)
import Html.Attributes exposing (class, rel, href, classList, style)
import Html.Events exposing (onClick)
import Navigation
import Array


{--Messages --}


type Msg
    = Noop
    | SelectStory String
    | UrlChange Navigation.Location
    | NavigateToHome



{--Model --}


{-| A UI represents a view and lists a set of stories
-}
type UI
    = UIType
        { id : String
        , description : String
        , viewStories : UIViewConfig -> Html Msg
        }


{-| Represents a familly of related views.
For example using [Atomic Design](http://bradfrost.com/blog/post/atomic-web-design/), we can have the following categories : Atoms, Molecules etc..
-}
type UICategory
    = UICategoryType InternalUICategory


type alias InternalUICategory =
    ( String, List UI )


type alias UIViewConfig =
    { selectedUIId : Maybe String
    , selectedStoryId : Maybe String
    }


{-| Model of the UI Explorer
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


makeStoryUrl : Model -> String -> Maybe String
makeStoryUrl model storyId =
    Maybe.map2
        (\selectedCategory selectedUIId ->
            [ selectedCategory, selectedUIId, storyId ]
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

        SelectStory storyId ->
            case makeStoryUrl model storyId of
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


toCategories : List InternalUICategory -> List UICategory
toCategories list =
    List.map UICategoryType list


{-|
   Create empty list of categories
-}
emptyUICategories : List UICategory
emptyUICategories =
    []


createUI : String -> String -> (UIViewConfig -> Html Msg) -> UI
createUI id description viewStories =
    UIType
        { id = id
        , description = description
        , viewStories = viewStories
        }


{-|
   Add Category to a list of categories
-}
addUICategory : String -> String -> String -> (UIViewConfig -> Html Msg) -> List UICategory -> List UICategory
addUICategory title id description viewStories categories =
    let
        category =
            UICategoryType
                ( title
                , [ createUI id description viewStories
                  ]
                )
    in
        category :: categories


{-| Launches a UIExplorer Applicaton given a list of categories
UICategoryType ( title, categories )
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


sizes =
    { commonMargin = 40
    , headerHeight = 100
    , headerMargin = 20
    , stateNavigationMargin = 20
    , stateButtonsMargin = 10
    , sidebarWidth = 200
    , storyContentPadding = 10
    , storyContentWidth = 370
    , categoryPaddingLeft = 40
    , categoryPadding = 10
    , categoryHeight = 40
    , categoryLineHeight = 38
    }


toPx : Int -> String
toPx prop =
    (prop |> toString) ++ "px"


styles =
    { logo = style [ ( "paddingLeft", sizes.commonMargin |> toPx ) ]
    , sidebarItem = style [ ( "width", sizes.sidebarWidth |> toPx ) ]
    , sidebarItemCategory =
        style
            [ ( "width", sizes.sidebarWidth |> toPx )
            , ( "borderBottom", "1px solid #999" )
            , ( "color", "#222" )
            , ( "width", sizes.sidebarWidth |> toPx )
            , ( "displayFlex", "" )
            , ( "height", sizes.categoryHeight |> toPx )
            , ( "lineHeight", sizes.categoryLineHeight |> toPx )
            , ( "marginBottom", 0 |> toPx )
            , ( "padding", sizes.categoryPadding |> toPx )
            , ( "paddingLeft", sizes.categoryPaddingLeft |> toPx )
            ]
    , sidebarItemLink =
        style
            [ ( "paddingLeft", sizes.commonMargin + 10 |> toPx )
            , ( "color", "#666" )
            ]
    , stateNavigation =
        style
            [ ( "margin", sizes.stateNavigationMargin |> toPx )
            , ( "marginLeft", sizes.stateButtonsMargin |> toPx )
            ]
    , stateButton = style [ ( "marginRight", sizes.stateButtonsMargin |> toPx ) ]
    , storyContent = style [ ( "paddingLeft", sizes.storyContentPadding |> toPx ) ]
    , description =
        style
            [ ( "margin", sizes.storyContentPadding |> toPx )
            , ( "paddingTop", sizes.storyContentPadding |> toPx )
            , ( "marginTop", (sizes.storyContentPadding * 4) |> toPx )
            , ( "borderTop", "1px solid #999" )
            ]
    , header =
        style
            [ ( "height", sizes.headerHeight |> toPx )
            , ( "paddingTop", sizes.headerMargin |> toPx )
            , ( "borderBottom", "1px solid #FFFFFF" )
            ]
    , welcome =
        style
            [ ( "margin", sizes.storyContentPadding |> toPx )
            , ( "width", sizes.storyContentWidth |> toPx )
            ]
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
viewMenuItem category selectedUIId (UIType ui) =
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
viewMenuCategory { selectedUIId, selectedStoryId } (UICategoryType ( title, categories )) =
    div []
        [ a
            [ class "menu-label", styles.sidebarItemCategory ]
            [ text ("> " ++ title) ]
        , ul [ class "menu-list" ]
            (List.map (viewMenuItem title selectedUIId) categories)
        ]


viewMenu : List UICategory -> UIViewConfig -> Html Msg
viewMenu categories config =
    aside [ class "menu", style [ ( "marginTop", 0 |> toPx ) ] ]
        (List.map (viewMenuCategory config) categories)


filterSelectedUI : UI -> Model -> Bool
filterSelectedUI (UIType ui) model =
    Maybe.map (\id -> ui.id == id) model.selectedUIId
        |> Maybe.withDefault False


getUIListFromCategories : UICategory -> List UI
getUIListFromCategories (UICategoryType ( title, categories )) =
    categories


viewContent : Model -> Html Msg
viewContent model =
    let
        filteredUIs =
            model.categories
                |> List.map getUIListFromCategories
                |> List.foldr (++) []
                |> List.filter (\ui -> filterSelectedUI ui model)

        viewConfig =
            { selectedStoryId = model.selectedStoryId
            , selectedUIId = model.selectedUIId
            }
    in
        div []
            [ filteredUIs
                |> List.map (\(UIType s) -> s.viewStories viewConfig)
                |> List.head
                |> Maybe.withDefault
                    (div [ styles.welcome ]
                        [ span [ class "subtitle is-4 has-text-grey" ] [ text "We’re not designing pages, we’re designing systems of components." ]
                        , span [ class "subtitle is-5" ] [ text "—Stephen Hay" ]
                        ]
                    )
            , article []
                (filteredUIs
                    |> List.map (\(UIType s) -> div [ styles.description ] [ text s.description ])
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
renderStories : (a -> Html msg) -> List ( String, a ) -> UIViewConfig -> Html Msg
renderStories storyView stories config =
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
