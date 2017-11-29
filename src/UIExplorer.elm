module UIExplorer
    exposing
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

import Html exposing (Html)
import Html exposing (Html, aside, ul, li, a, span, text, div, section, h1, h2, node, article, img)
import Html.Attributes exposing (class, rel, href, classList, style, src)
import Html.Events exposing (onClick)
import Navigation
import Array
import Tailwind.Classes as T
import String


{--Messages --}


type Msg
    = Noop
    | SelectStory String
    | UrlChange Navigation.Location
    | NavigateToHome



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
   Creates an empty list of UI Categories
-}
emptyUICategories : List UICategory
emptyUICategories =
    []


{-|
   Create a UI given an ID and Story Views
```
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
```

-}
createUI : String -> (UIViewConfig -> Html Msg) -> UI
createUI id viewStories =
    createUIWithDescription id "" viewStories


{-|
   Create a UI with a description
   ```
   createUI "Button" "A Simple Button :-)" viewStories

   ```
-}
createUIWithDescription : String -> String -> (UIViewConfig -> Html Msg) -> UI
createUIWithDescription id description viewStories =
    UIType
        { id = id
        , description = description
        , viewStories = viewStories
        }


{-|
   Create a list of [UICategories](#UICategories) from a list of [UI](#UI) and Add them in a Default Category.
   This is the simplest way to initialize the UI Explorer app.
   ```
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
   ```
-}
fromUIList : List UI -> List UICategory
fromUIList uiList =
    emptyUICategories |> List.append [ (UICategoryType ( "Default", uiList )) ]


{-|
   Adds a UI Category to a list of categories
   Convenient for running a UI Explorer devided into categories
```
   emptyUICategories
       |> addUICategory
           "A Great Category"
           [ createUI
               "My View"
               MyView.viewStories
           ]
```
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


{-| Launches a UI Explorer Applicaton given a list of UI Categories

```
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
```

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


colors =
    { bg =
        { primary = T.bg_purple_dark
        }
    }


toClassName list =
    class
        (list
            |> List.map (\c -> "uie-" ++ c)
            |> String.join " "
        )


hover className =
    T.hover ++ ":" ++ className


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
        [ T.cursor_pointer ]
    , header =
        [ colors.bg.primary
        , T.p_2
        , T.text_white
        , T.shadow_md
        ]
    , title =
        [ T.font_normal
        , T.text_3xl
        , T.text_black
        ]
    , subTitle =
        [ T.font_normal
        , T.text_3xl
        , T.text_grey
        ]
    }


viewHeader : Html Msg
viewHeader =
    section
        [ toClassName styleHeader.header ]
        [ div
            [ toClassName [ T.bg_cover, T.cursor_pointer, "logo" ]
            , onClick NavigateToHome
            ]
            []
        ]


styleMenuItem isSelected =
    let
        defaultClass =
            [ T.w_full
            , T.flex
            , T.pl_6
            , T.pt_2
            , T.pb_2
            , hover T.bg_purple_darker
            , hover T.text_white
            ]
    in
        if isSelected then
            defaultClass
                |> List.append
                    [ colors.bg.primary, T.text_white ]
        else
            defaultClass
                |> List.append
                    [ T.text_grey_darker ]


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
    [ T.text_grey_darkest
    , T.uppercase
    , T.border_b
    , T.border_grey_light
    , T.w_full
    , T.flex
    , T.cursor_default
    , T.pl_4
    , T.pb_2
    , T.pt_2
    , T.text_sm
    ]


viewMenuCategory : UIViewConfig -> UICategory -> Html Msg
viewMenuCategory { selectedUIId, selectedStoryId } (UICategoryType ( title, categories )) =
    div [ toClassName [ T.flex_col ] ]
        [ a
            [ toClassName styleMenuCategoryLink
            ]
            [ text ("> " ++ title) ]
        , ul [ toClassName [ T.list_reset ] ]
            (List.map (viewMenuItem title selectedUIId) categories)
        ]


viewMenu : List UICategory -> UIViewConfig -> Html Msg
viewMenu categories config =
    aside
        [ toClassName
            [ T.mt_8
            ]
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
        div [ toClassName [ T.m_6 ] ]
            [ filteredUIs
                |> List.map (\(UIType s) -> s.viewStories viewConfig)
                |> List.head
                |> Maybe.withDefault
                    (div [ toClassName [ T.m_6 ] ]
                        [ span [ toClassName [ T.text_2xl, T.flex, T.mb_1 ] ] [ text "We’re not designing pages, we’re designing systems of components." ]
                        , span
                            [ toClassName [ T.text_lg, T.flex, T.text_grey_darker ] ]
                            [ text "-Stephen Hay" ]
                        ]
                    )
            , article []
                (filteredUIs
                    |> List.map (\(UIType s) -> div [] [ text s.description ])
                )
            ]


oneThird =
    T.w_1 ++ "/3"


oneQuarter =
    T.w_1 ++ "/4"


view : Model -> Html Msg
view model =
    div [ toClassName [ T.h_screen ] ]
        [ viewHeader
        , div [ toClassName [ T.flex ] ]
            [ div
                [ toClassName
                    [ oneQuarter
                    , T.bg_white
                    , T.h_screen
                    ]
                ]
                [ viewSidebar model ]
            , div
                [ toClassName
                    [ T.p_4
                    , T.bg_white
                    , T.w_screen
                    , T.h_screen
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
            [ T.mr_2
            , T.mb_2
            , T.rounded
            , T.p_2
            , T.text_sm
            ]

        liClass =
            if isActive then
                [ colors.bg.primary
                , T.text_white
                , T.cursor_default
                ]
                    |> List.append defaultLiClass
            else
                [ T.border
                , T.border_grey_light
                , T.bg_white
                , T.cursor_pointer
                , hover T.bg_purple_darker
                , hover T.text_white
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
```
stories : List ( String, Model )
stories =
    [ ( "Loading", { isLoading = True } ), ( "Loaded", { isLoading = False } ) ]

viewStories = renderStories (view model) stories
```
-}
renderStories : (a -> Html msg) -> List ( String, a ) -> UIViewConfig -> Html Msg
renderStories storyView stories config =
    let
        { selectedStoryId } =
            config

        menu =
            ul [ toClassName [ T.flex, T.mb_4 ] ] (List.indexedMap (\index -> renderStory index config) stories)

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
