module ElmjutsuDumMyM0DuL3 exposing (..)
-- exposing
-- ( explore
-- , exploreWithCategories
-- , UI
-- , UICategory
-- , Model
-- , Msg(..)
-- , UIExplorerProgram
-- , addUICategory
-- , storiesOf
-- , ViewEnhancer
-- , defaultConfig
-- , findStory
-- , getCurrentSelectedStory
-- , emptyUICategories
-- , UIViewConfig
-- )

{-|


# Anatomy of the UI Explorer

  - The Explorer is devided into a list of [UICategory](#UICategory) (ex: Buttons)
  - Each Category contains some [UI](#UI) items (ex: ToggleButton, ButtonWithImage, SubmitButton etc...)
  - Each [UI](#UI) item defines states (ex: Loaded, Disabled etc..) that we usually call [stories](https://storybook.js.org/basics/writing-stories/)


# Main API

@docs explore
@docs exploreWithCategories


# Models

@docs UI
@docs UICategory
@docs Model
@docs Msg
@docs UIExplorerProgram


# Helpers

@docs addUICategory
@docs storiesOf
@docs ViewEnhancer
@docs defaultConfig
@docs findStory
@docs getCurrentSelectedStory
@docs emptyUICategories

-}

import Array exposing (Array)
import Browser
import Browser.Navigation as Navigation
import Html exposing (Html, a, article, aside, div, h1, h2, img, li, node, section, span, text, ul)
import Html.Attributes exposing (class, classList, href, rel, src, style)
import Html.Events exposing (onClick)
import Url


type alias UIExplorerProgram a b c =
    Program () (Model a b c) (Msg b)


type alias MenuViewEnhancer a b c =
    Model a b c -> Html (Msg b) -> Html (Msg b)


type alias ViewEnhancer a b c =
    Model a b c -> Html (Msg b) -> Html (Msg b)


type alias Story a b c =
    ( String, Model a b c -> Html b, c )


type alias Stories a b c =
    List (Story a b c)


getStoryIdFromStories : ( String, Model a b c -> Html b, c ) -> String
getStoryIdFromStories ( s, _, _ ) =
    s



{--Messages --}


type Msg a
    = ExternalMsg a
    | SelectStory String
    | UrlChange Url.Url
    | LinkClicked Browser.UrlRequest
    | NoOp



{--Model --}


{-| A UI represents a view and lists a set of stories.
For Example : A Button with following stories (Loading, Disabled)
-}
type UI a b c
    = UIType
        { id : String
        , description : String
        , viewStories : Stories a b c
        }


{-| Represents a familly of related views.
For example using [Atomic Design](http://bradfrost.com/blog/post/atomic-web-design/), we can have the following categories : Atoms, Molecules etc..
-}
type UICategory a b c
    = UICategoryType (InternalUICategory a b c)


type alias InternalUICategory a b c =
    ( String, List (UI a b c) )


type alias UIViewConfig =
    { selectedUIId : Maybe String
    , selectedStoryId : Maybe String
    }


{-| Model of the UI Explorer
-}
type alias Model a b c =
    { categories : List (UICategory a b c)
    , selectedUIId : Maybe String
    , selectedStoryId : Maybe String
    , selectedCategory : Maybe String
    , url : Url.Url
    , key : Navigation.Key
    , customModel : a
    }


type alias Config a b c =
    { customModel : a
    , update : b -> Model a b c -> Model a b c
    , viewEnhancer : ViewEnhancer a b c
    , menuViewEnhancer : MenuViewEnhancer a b c
    }


defaultConfig : Config {} b c
defaultConfig =
    { customModel = {}
    , update =
        \msg m -> m
    , viewEnhancer = \m stories -> stories
    , menuViewEnhancer = \m v -> v
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


join : Maybe (Maybe a) -> Maybe a
join mx =
    case mx of
        Just x ->
            x

        Nothing ->
            Nothing


getCurrentSelectedStory : Model a b c -> Maybe (Story a b c)
getCurrentSelectedStory { selectedUIId, selectedStoryId, categories } =
    Maybe.map2 (\a b -> ( a, b )) selectedUIId selectedStoryId
        |> Maybe.map (\( a, b ) -> findStory a b categories)
        |> join


findStory : String -> String -> List (UICategory a b c) -> Maybe (Story a b c)
findStory uiId storyId categories =
    let
        foundStory =
            List.map
                (\(UICategoryType ( a, b )) -> b)
                categories
                |> List.concat
                |> List.filter (\(UIType ui) -> ui.id == uiId)
                |> List.map (\(UIType ui) -> ui.viewStories)
                |> List.concat
                |> List.filter (\s -> getStoryIdFromStories s == storyId)
    in
    List.head foundStory


makeStoryUrl : Model a b c -> String -> Maybe String
makeStoryUrl model storyId =
    Maybe.map2
        (\selectedCategory selectedUIId ->
            [ selectedCategory, selectedUIId, storyId ]
                |> String.join "/"
                |> (++) "#"
        )
        model.selectedCategory
        model.selectedUIId


update : Config a b c -> Msg b -> Model a b c -> ( Model a b c, Cmd (Msg b) )
update config msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ExternalMsg subMsg ->
            let
                newModel =
                    config.update subMsg model
            in
            ( newModel, Cmd.none )

        SelectStory storyId ->
            case makeStoryUrl model storyId of
                Just url ->
                    ( model, Navigation.pushUrl model.key url )

                Nothing ->
                    ( model, Cmd.none )

        UrlChange location ->
            ( { model
                | url = location
                , selectedUIId = getSelectedUIfromPath location
                , selectedStoryId = getSelectedStoryfromPath location
                , selectedCategory = getSelectedCategoryfromPath location
              }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Navigation.load href )


toCategories : List (InternalUICategory a b c) -> List (UICategory a b c)
toCategories list =
    List.map UICategoryType list


{-| Creates an empty list of UI Categories
-}
emptyUICategories : List (UICategory a b c)
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

    storiesOf "Button" viewStories

-}
storiesOf : String -> Stories a b c -> UI a b c
storiesOf id stories =
    UIType
        { id = id
        , description = ""
        , viewStories = stories
        }


{-| Create a list of [UICategories](#UICategories) from a list of [UI](#UI) and Add them in a Default Category.
This is the simplest way to initialize the UI Explorer app.

    main =
        app
            (explore
                [ storiesOf
                    "PlayPause"
                    PlayPause.viewStories
                , storiesOf
                    "Controls"
                    Controls.viewStories
                , storiesOf
                    "TrackList"
                    TrackList.viewStories
                ]
            )

-}
fromUIList : List (UI a b c) -> List (UICategory a b c)
fromUIList uiList =
    emptyUICategories |> List.append [ UICategoryType ( "Default", uiList ) ]


{-| Adds a UI Category to a list of categories
Convenient for running a UI Explorer devided into categories

       emptyUICategories
           |> addUICategory
               "A Great Category"
               [ storiesOf
                   "My View"
                   MyView.viewStories
               ]

-}
addUICategory : String -> List (UI a b c) -> List (UICategory a b c) -> List (UICategory a b c)
addUICategory title uiList categories =
    let
        category =
            UICategoryType
                ( title
                , uiList
                )
    in
    List.append categories [ category ]


getDefaultUrlFromCategories : List (UICategory a b c) -> String
getDefaultUrlFromCategories categories =
    categories
        |> List.head
        |> Maybe.map
            (\(UICategoryType ( cat, uiList )) ->
                let
                    maybeDefaultStr =
                        Maybe.withDefault ""

                    ui =
                        List.head uiList
                            |> Maybe.map (\(UIType { id }) -> id)
                            |> maybeDefaultStr

                    story =
                        List.head uiList
                            |> Maybe.map
                                (\(UIType { viewStories }) ->
                                    List.head viewStories
                                        |> Maybe.map getStoryIdFromStories
                                        |> maybeDefaultStr
                                )
                            |> maybeDefaultStr
                in
                "#" ++ cat ++ "/" ++ ui ++ "/" ++ story
            )
        |> Maybe.withDefault ""


init : a -> List (UICategory a b c) -> () -> Url.Url -> Navigation.Key -> ( Model a b c, Cmd (Msg b) )
init customModel categories flags url key =
    let
        selectedUIId =
            getSelectedUIfromPath url

        selectedStoryId =
            getSelectedStoryfromPath url

        selectedCategory =
            getSelectedCategoryfromPath url

        firstUrl =
            Maybe.map3 (\cat ui story -> "#" ++ cat ++ "/" ++ ui ++ "/" ++ story)
                selectedCategory
                selectedUIId
                selectedStoryId
                |> Maybe.withDefault (getDefaultUrlFromCategories categories)
    in
    ( { categories = categories
      , selectedUIId = selectedUIId
      , selectedStoryId = selectedStoryId
      , selectedCategory = selectedCategory
      , url = url
      , key = key
      , customModel = customModel
      }
    , Navigation.pushUrl key firstUrl
    )


app : Config a b c -> List (UICategory a b c) -> UIExplorerProgram a b c
app config categories =
    Browser.application
        { init = init config.customModel categories
        , view =
            \model ->
                { title = "Storybook Elm"
                , body =
                    [ view config model
                    ]
                }
        , update = update config
        , onUrlChange = UrlChange
        , onUrlRequest = LinkClicked
        , subscriptions = \_ -> Sub.none
        }


{-| Launches a UI Explorer Applicaton given a list of [UI](#UI).
This is the simplest way to initialize the UI Explorer app.

    button : String -> String -> Html.Html msg
    button label bgColor =
        Html.button
            [ style "background-color" bgColor ]
            [ Html.text label ]

    main : UIExplorerProgram {} () {}
    main =
        explore
            [ storiesOf
                "Button"
                [ ( "SignIn", \_ -> button "Sign In" "pink", {} )
                , ( "SignOut", \_ -> button "Sign Out" "cyan", {} )
                , ( "Loading", \_ -> button "Loading please wait..." "white", {} )
                ]
            ]
            defaultConfig

-}
explore config uiList =
    app config (fromUIList uiList)


exploreWithCategories config categories =
    app config categories



{--VIEW --}


colors : { bg : { primary : String } }
colors =
    { bg =
        { primary = "bg-black"
        }
    }


toClassName : List String -> Html.Attribute msg
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


hover : String -> String
hover className =
    "hover:uie-" ++ className


viewSidebar : Model a b c -> Html (Msg b)
viewSidebar model =
    let
        viewConfig =
            { selectedStoryId = model.selectedStoryId
            , selectedUIId = model.selectedUIId
            }
    in
    viewMenu model.categories viewConfig


styleHeader :
    { header : List String
    , logo : List String
    , subTitle : List String
    , title : List String
    }
styleHeader =
    { logo =
        [ "cursor-default" ]
    , header =
        [ colors.bg.primary, "p-0", "pb-2", "text-white", "shadow-md" ]
    , title =
        [ "font-normal", "text-3xl", "text-black" ]
    , subTitle =
        [ "font-normal", "text-3xl", "text-grey" ]
    }


viewHeader : Html (Msg b)
viewHeader =
    section
        [ toClassName styleHeader.header ]
        [ div
            [ toClassName [ "bg-cover", "cursor-default", "logo" ]
            ]
            []
        ]


styleMenuItem : Bool -> List String
styleMenuItem isSelected =
    let
        defaultClass =
            [ "w-full"
            , "flex"
            , "pl-6"
            , "pt-2"
            , "pb-2"
            , hover "bg-grey-lighter"
            , hover "text-black"
            ]
    in
    if isSelected then
        defaultClass
            |> List.append
                [ "text-black", "bg-grey-light" ]

    else
        defaultClass
            |> List.append
                [ "text-grey-darker" ]


viewMenuItem : String -> Maybe String -> UI a b c -> Html (Msg b)
viewMenuItem category selectedUIId (UIType ui) =
    let
        defaultLink =
            case ui.viewStories |> List.head of
                Just story ->
                    "#" ++ category ++ "/" ++ ui.id ++ "/" ++ getStoryIdFromStories story

                Nothing ->
                    "#" ++ category ++ "/" ++ ui.id

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
            , href defaultLink
            ]
            [ text ui.id ]
        ]


styleMenuCategoryLink : List String
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


viewMenuCategory : UIViewConfig -> UICategory a b c -> Html (Msg b)
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


viewMenu : List (UICategory a b c) -> UIViewConfig -> Html (Msg b)
viewMenu categories config =
    aside
        [ toClassName
            [ "mt-8" ]
        ]
        (List.map (viewMenuCategory config) categories)


filterSelectedUI : UI a b c -> Model a b c -> Bool
filterSelectedUI (UIType ui) model =
    Maybe.map (\id -> ui.id == id) model.selectedUIId
        |> Maybe.withDefault False


getUIListFromCategories : UICategory a b c -> List (UI a b c)
getUIListFromCategories (UICategoryType ( title, categories )) =
    categories


viewContent : Config a b c -> Model a b c -> Html (Msg b)
viewContent config model =
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
            |> List.map (\(UIType s) -> config.viewEnhancer model (renderStories config s.viewStories viewConfig model))
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


oneThird : String
oneThird =
    "w-1/3"


oneQuarter : String
oneQuarter =
    "w-1/4"


view : Config a b c -> Model a b c -> Html (Msg b)
view config model =
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
                [ viewContent config model ]
            ]
        ]


renderStory : Int -> UIViewConfig -> ( String, a, c ) -> Html (Msg b)
renderStory index { selectedStoryId } ( id, state, _ ) =
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
                [ "border"
                , "border-black"
                , "text-black"
                , "cursor-default"
                ]
                    |> List.append defaultLiClass

            else
                [ "border"
                , "border-grey"
                , "bg-white"
                , "text-grey"
                , "cursor-pointer"
                , hover "bg-grey-lighter"
                ]
                    |> List.append defaultLiClass
    in
    li
        [ toClassName liClass
        , onClick <| SelectStory id
        , buttonClass
        ]
        [ text id ]


renderStories : Config a b c -> Stories a b c -> UIViewConfig -> Model a b c -> Html (Msg b)
renderStories config stories viewConfig model =
    let
        { selectedStoryId } =
            viewConfig

        menu =
            config.menuViewEnhancer model (ul [ toClassName [ "list-reset", "flex", "mb-4" ] ] (List.indexedMap (\index -> renderStory index viewConfig) stories))

        currentStories =
            case selectedStoryId of
                Just selectedId ->
                    List.filter (\( id, state, _ ) -> id == selectedId) stories

                Nothing ->
                    stories

        content =
            case currentStories |> List.head of
                Just ( id, story, _ ) ->
                    story model |> Html.map (\_ -> NoOp)

                Nothing ->
                    text "Include somes states in your story..."
    in
    div []
        [ menu
        , div [] [ content ]
        ]
