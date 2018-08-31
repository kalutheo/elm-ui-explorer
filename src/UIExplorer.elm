module UIExplorer exposing
    ( app
    , renderStories
    , UI
    , UICategory
    , addUICategory
    , emptyUICategories
    , createUI
    , createUIWithDescription
    , fromUIList
    )

{-|


# Anatomy of the UI Explorer

  - The Explorer is devided into a list of [UICategory](#UICategory) (ex: Buttons)
  - Each Category contains some [UI](#UI) items (ex: ToggleButton, ButtonWithImage, SubmitButton etc...)
  - Each [UI](#UI) item defines states (ex: Loaded, Disabled etc..) that we usually call [stories](https://storybook.js.org/basics/writing-stories/)


# Main API

@docs app
@docs renderStories


# Models

@docs UI
@docs UICategory


# Helpers

@docs addUICategory
@docs emptyUICategories
@docs createUI
@docs createUIWithDescription
@docs fromUIList

-}

import Array exposing (Array)
import Browser
import Browser.Navigation as Navigation
import Html exposing (Html, a, article, aside, div, h1, h2, img, li, node, section, span, text, ul)
import Html.Attributes exposing (class, classList, href, rel, src, style)
import Html.Events exposing (onClick)
import Url



{--Messages --}


type Msg
    = Noop
    | SelectStory String
    | UrlChange Url.Url
    | NavigateToHome
    | LinkClicked Browser.UrlRequest



{--Model --}


{-| A UI represents a view and lists a set of stories.
For Example : A Button with following stories (Loading, Disabled)
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
    , url : Url.Url
    , key : Navigation.Key
    }


fragmentToArray : String -> Array String
fragmentToArray fragment =
    fragment
        |> String.split "/"
        |> Array.fromList


getFragmentSegmentByIndex : Maybe String -> Int -> Maybe String
getFragmentSegmentByIndex fragment index =
    fragment |> Maybe.withDefault "" |> fragmentToArray |> Array.get index


getSelectedCategoryfromPath : Url.Url -> Maybe String
getSelectedCategoryfromPath { fragment } =
    getFragmentSegmentByIndex fragment 0


getSelectedUIfromPath : Url.Url -> Maybe String
getSelectedUIfromPath { fragment } =
    getFragmentSegmentByIndex fragment 1


getSelectedStoryfromPath : Url.Url -> Maybe String
getSelectedStoryfromPath { fragment } =
    getFragmentSegmentByIndex fragment 2


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
                    ( model, Navigation.pushUrl model.key url )

                Nothing ->
                    ( model, Cmd.none )

        UrlChange location ->
            let
                _ =
                    Debug.log "UrlChange" location
            in
            ( { model
                | url = location
                , selectedUIId = getSelectedUIfromPath location
                , selectedStoryId = getSelectedStoryfromPath location
                , selectedCategory = getSelectedCategoryfromPath location
              }
            , Cmd.none
            )

        NavigateToHome ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Navigation.load href )


toCategories : List InternalUICategory -> List UICategory
toCategories list =
    List.map UICategoryType list


{-| Creates an empty list of UI Categories
-}
emptyUICategories : List UICategory
emptyUICategories =
    []


{-| Create a UI given an ID and Story Views

    stories : List ( String, ButtonModel )
    stories =
        [ ( "LargePrimary", { label = "Primary", isLarge = True, isPrimary = True } )
        , ( "TinyPrimary", { label = "Primary", isLarge = False, isPrimary = True } )
        , ( "LargeSecondary", { label = "Secondary", isLarge = True, isPrimary = False } )
        , ( "TinySecondary", { label = "Secondary", isLarge = False, isPrimary = False } )
        ]


    viewStories =
        renderStories customButton stories

    createUI "Button" viewStories

-}
createUI : String -> (UIViewConfig -> Html Msg) -> UI
createUI id viewStories =
    createUIWithDescription id "" viewStories


{-| Create a UI with a description

    createUI "Button" "A Simple Button :-)" viewStories

-}
createUIWithDescription : String -> String -> (UIViewConfig -> Html Msg) -> UI
createUIWithDescription id description viewStories =
    UIType
        { id = id
        , description = description
        , viewStories = viewStories
        }


{-| Create a list of [UICategories](#UICategories) from a list of [UI](#UI) and Add them in a Default Category.
This is the simplest way to initialize the UI Explorer app.

    main =
        app
            (fromUIList
                [ createUI
                    "PlayPause"
                    PlayPause.viewStories
                , createUI
                    "Controls"
                    Controls.viewStories
                , createUI
                    "TrackList"
                    TrackList.viewStories
                ]
            )

-}
fromUIList : List UI -> List UICategory
fromUIList uiList =
    emptyUICategories |> List.append [ UICategoryType ( "Default", uiList ) ]


{-| Adds a UI Category to a list of categories
Convenient for running a UI Explorer devided into categories

       emptyUICategories
           |> addUICategory
               "A Great Category"
               [ createUI
                   "My View"
                   MyView.viewStories
               ]

-}
addUICategory : String -> List UI -> List UICategory -> List UICategory
addUICategory title uiList categories =
    let
        category =
            UICategoryType
                ( title
                , uiList
                )
    in
    List.append categories [ category ]


init : List UICategory -> () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init categories flags url key =
    let
        _ =
            Debug.log "init" (Debug.toString key)
    in
    ( { categories = categories
      , selectedUIId = getSelectedUIfromPath url
      , selectedStoryId = getSelectedStoryfromPath url
      , selectedCategory = getSelectedCategoryfromPath url
      , url = url
      , key = key
      }
    , Cmd.none
    )


{-| Launches a UI Explorer Applicaton given a list of UI Categories

    main =
        app
            (emptyUICategories
                |> addUICategory
                    "Atoms"
                    [ createUIWithDescription
                        "Colors"
                        "Global Color Schemes"
                        Colors.viewStories
                    ]
                |> addUICategory
                    "Molecules"
                    [ createUI
                        "Card"
                        Card.viewStories
                    ]
            )

-}
app categories =
    Browser.application
        { init = init categories
        , view =
            \model ->
                { title = "Storybook Elm"
                , body =
                    [ view model
                    ]
                }
        , update = update
        , onUrlChange = UrlChange
        , onUrlRequest = LinkClicked
        , subscriptions = \_ -> Sub.none
        }



{--VIEW --}


colors =
    { bg =
        { primary = "bg-purple-dark"
        }
    }


toClassName list =
    class
        (list
            |> List.map
                (\c ->
                    if c |> String.contains "hover" then
                        c

                    else
                        "uie-" ++ c
                )
            |> String.join " "
        )


hover className =
    "hover:uie-" ++ className


viewSidebar : Model -> Html Msg
viewSidebar model =
    let
        viewConfig =
            { selectedStoryId = model.selectedStoryId
            , selectedUIId = model.selectedUIId
            }
    in
    viewMenu model.categories viewConfig


styleHeader =
    { logo =
        [ "cursor-pointer" ]
    , header =
        [ colors.bg.primary, "p-0", "pb-2", "text-white", "shadow-md" ]
    , title =
        [ "font-normal", "text-3xl", "text-black" ]
    , subTitle =
        [ "font-normal", "text-3xl", "text-grey" ]
    }


viewHeader : Html Msg
viewHeader =
    section
        [ toClassName styleHeader.header ]
        [ div
            [ toClassName [ "bg-cover", "cursor-pointer", "logo" ]
            , onClick NavigateToHome
            ]
            []
        ]


styleMenuItem isSelected =
    let
        defaultClass =
            [ "w-full"
            , "flex"
            , "pl-6"
            , "pt-2"
            , "pb-2"
            , hover "bg-purple-darker"
            , hover "text-white"
            ]
    in
    if isSelected then
        defaultClass
            |> List.append
                [ colors.bg.primary, "text-white" ]

    else
        defaultClass
            |> List.append
                [ "text-grey-darker" ]


viewMenuItem : String -> Maybe String -> UI -> Html Msg
viewMenuItem category selectedUIId (UIType ui) =
    let
        isSelected =
            selectedUIId
                |> Maybe.map ((==) ui.id)
                |> Maybe.withDefault False

        linkClass =
            styleMenuItem isSelected
    in
    li [ toClassName [] ]
        [ a
            [ toClassName linkClass
            , href ("#" ++ category ++ "/" ++ ui.id)
            ]
            [ text ui.id ]
        ]


styleMenuCategoryLink =
    [ "text-grey-darkest"
    , "uppercase"
    , "border-b"
    , "border-grey-light"
    , "w-full"
    , "flex"
    , "cursor-default"
    , "pl-4"
    , "pb-2"
    , "pt-2"
    , "text-sm"
    ]


viewMenuCategory : UIViewConfig -> UICategory -> Html Msg
viewMenuCategory { selectedUIId, selectedStoryId } (UICategoryType ( title, categories )) =
    div [ toClassName [] ]
        [ a
            [ toClassName styleMenuCategoryLink
            , href "#"
            ]
            [ span [ toClassName [ "font-bold", "text-grey-darker" ] ] [ text ("> " ++ title) ] ]
        , ul [ toClassName [ "list-reset" ] ]
            (List.map (viewMenuItem title selectedUIId) categories)
        ]


viewMenu : List UICategory -> UIViewConfig -> Html Msg
viewMenu categories config =
    aside
        [ toClassName
            [ "mt-8" ]
        ]
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
    div [ toClassName [ "m-6" ] ]
        [ filteredUIs
            |> List.map (\(UIType s) -> s.viewStories viewConfig)
            |> List.head
            |> Maybe.withDefault
                (div [ toClassName [] ]
                    [ span
                        [ toClassName
                            [ "text-grey-darkest"
                            , "text-xl"
                            , "flex"
                            , "mb-1"
                            ]
                        ]
                        [ text "We’re not designing pages, we’re designing systems of components." ]
                    , span
                        [ toClassName
                            [ "text-lg"
                            , "flex"
                            , "text-grey-darker"
                            ]
                        ]
                        [ text "-Stephen Hay" ]
                    ]
                )
        , article []
            (filteredUIs
                |> List.map (\(UIType s) -> div [] [ text s.description ])
            )
        ]


oneThird =
    "w-1/3"


oneQuarter =
    "w-1/4"


view : Model -> Html Msg
view model =
    div [ toClassName [ "h-screen" ] ]
        [ viewHeader
        , div [ toClassName [ "flex" ] ]
            [ div
                [ toClassName
                    [ oneQuarter
                    , "bg-white"
                    , "h-screen"
                    ]
                ]
                [ viewSidebar model ]
            , div
                [ toClassName
                    [ "p-4"
                    , "bg-white"
                    , "w-screen"
                    , "h-screen"
                    ]
                ]
                [ viewContent model ]
            ]
        ]


renderStory : Int -> UIViewConfig -> ( String, a ) -> Html Msg
renderStory index { selectedStoryId } ( id, state ) =
    let
        isActive =
            Maybe.map (\theId -> id == theId) selectedStoryId
                |> Maybe.withDefault (index == 0)

        buttonClass =
            classList [ ( "", True ), ( "", isActive ) ]

        defaultLiClass =
            [ "mr-2"
            , "mb-2"
            , "rounded"
            , "p-2"
            , "text-sm"
            ]

        liClass =
            if isActive then
                [ colors.bg.primary
                , "text-white"
                , "cursor-default"
                ]
                    |> List.append defaultLiClass

            else
                [ "border"
                , "border-grey-light"
                , "bg-white"
                , "cursor-pointer"
                , hover "bg-purple-darker"
                , hover "text-white"
                ]
                    |> List.append defaultLiClass
    in
    li
        [ toClassName liClass
        , onClick <| SelectStory id
        , buttonClass
        ]
        [ text id ]


{-| Renders Stories of a given UI.
A story represents a state of a view such as (Loading, Error, Success, NoNetwork ...)

    stories : List ( String, Model )
    stories =
        [ ( "Loading", { isLoading = True } ), ( "Loaded", { isLoading = False } ) ]

    viewStories =
        renderStories (view model) stories

-}
renderStories : (a -> Html msg) -> List ( String, a ) -> UIViewConfig -> Html Msg
renderStories storyView stories config =
    let
        { selectedStoryId } =
            config

        menu =
            ul [ toClassName [ "list-reset", "flex", "mb-4" ] ] (List.indexedMap (\index -> renderStory index config) stories)

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
        , div [] [ content ]
        ]
