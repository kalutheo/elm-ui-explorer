module UIExplorer exposing
    ( explore
    , exploreWithCategories
    , defaultConfig
    , UI
    , UICategory
    , Model
    , Msg(..)
    , UIExplorerProgram
    , Logo
    , Config
    , CustomHeader
    , ViewEnhancer
    , MenuViewEnhancer
    , getCurrentSelectedStory
    , category
    , storiesOf
    , createCategories
    , logoFromHtml
    , logoFromUrl
    )

{-|


# Anatomy of the UI Explorer

  - The Explorer is devided into a list of [UICategory](#UICategory) (ex: Buttons, Icons)
  - Each Category contains some [UI](#UI) items (ex: the Buttons Category can contain ToggleButton, ButtonWithImage, SubmitButton etc...)
  - Each [UI](#UI) item defines states (ex: Loaded, Disabled etc..) that we usually call [stories](https://storybook.js.org/basics/writing-stories/)


# How to explore my UI ?

@docs explore
@docs exploreWithCategories
@docs defaultConfig


# Types

@docs UI
@docs UICategory
@docs Model
@docs Msg
@docs UIExplorerProgram
@docs Logo


# Advanced

Elm UI Explorer can be extended with Plugins.
The package comes with core plugins and you can obviously create your own.
Theses plugins allow to customize the appearance of the UI Explorer.
Functions listed below are related to that.

@docs Config
@docs CustomHeader
@docs ViewEnhancer
@docs MenuViewEnhancer
@docs getCurrentSelectedStory


# Helpers

@docs category
@docs storiesOf
@docs createCategories
@docs logoFromHtml
@docs logoFromUrl

-}

import Array exposing (Array)
import Browser
import Browser.Navigation as Navigation
import FeatherIcons
import Html exposing (Html, a, article, aside, button, div, h3, header, img, li, span, text, ul)
import Html.Attributes exposing (class, classList, href, src, style)
import Html.Events exposing (onClick)
import Url


{-| The Elm Program created by the UI Explorer.

The three argument should only be changed when using Plugins.
Default values are sufficent most of the time.

  - a : Custom Model entry that can be used to store data related to Plugins
  - b : Message Type emitted by the UIExporer main view
  - c : Data related to Plugins and used by your Stories

-}
type alias UIExplorerProgram a b c =
    Program () (Model a b c) (Msg b)


{-| Gives a chance to Plugins to add features to the stories selection menu.
For example, the Menu Visibility Plugin allows to hide/show the menu :

    menuViewEnhancer =
        \model menuView ->
            getCurrentSelectedStory model
                |> Maybe.map
                    (\( _, _, option ) ->
                        if option.hasMenu then
                            menuView

                        else
                            Html.text ""
                    )
                |> Maybe.withDefault (Html.text "")

Then in your stories :

    storiesOf
        "About"
        [ ( "HideMenu", _ -> myView { hasMenu = False } ),
        ( "ShowMenu", _ -> myView { hasMenu = True } )
        ]

-}
type alias MenuViewEnhancer a b c =
    Model a b c -> Html (Msg b) -> Html (Msg b)


{-| Gives a chance to Plugins to add features to the main view canvas.
For example, the Notes plugin allows to add markdown notes for each stories:

    main : UIExplorerProgram {} () PluginOption
    main =
        explore
            { defaultConfig | viewEnhancer = ExplorerNotesPlugin.viewEnhancer }
            [ storiesOf
                "Button"
                [ ( "Primary", \_ -> Button.view "Submit" defaultButtonConfig (), {notes: "This is the primary style :-)"} )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary } (), {notes: "This is the secondary style"} )
            ]

-}
type alias ViewEnhancer a b c =
    Model a b c -> Html (Msg b) -> Html (Msg b)


type alias Story a b c =
    ( String, Model a b c -> Html b, c )


type alias Stories a b c =
    List (Story a b c)


type ColorMode
    = Dark
    | Light


type alias Theme =
    { primaryBgColor : String
    , primaryTextColor : String
    , iconColor : String
    , headerColor : String
    , sidebar :
        { background : String
        , borderColor : String
        }
    , menu :
        { selectedBg : String
        , hoverBg : String
        , hoverText : String
        , text : String
        }
    , storyMenu :
        { selectedBorder : String
        , selectedText : String
        , border : String
        , text : String
        , hoverBg : String
        }
    }


lightTheme : Theme
lightTheme =
    { primaryBgColor = "bg-white"
    , primaryTextColor = "text-grey-darker"
    , headerColor = "bg-white"
    , iconColor = "text-black"
    , sidebar =
        { background = "bg-white"
        , borderColor = "border-transparent"
        }
    , menu =
        { selectedBg = "bg-grey-light"
        , hoverBg = "bg-grey-lighter"
        , hoverText = "text-black"
        , text = "text-black"
        }
    , storyMenu =
        { selectedBorder = "border-black"
        , selectedText = "text-black"
        , border = "border-grey"
        , text = "text-grey"
        , hoverBg = "bg-grey-lighter"
        }
    }


darkTheme : Theme
darkTheme =
    { primaryBgColor = "bg-black"
    , primaryTextColor = "text-white"
    , headerColor = "bg-black"
    , iconColor = "text-white"
    , sidebar =
        { background = "bg-black"
        , borderColor = "border-grey-darkest"
        }
    , menu =
        { selectedBg = "bg-grey-darkest"
        , hoverBg = "bg-white"
        , hoverText = "text-black"
        , text = "text-white"
        }
    , storyMenu =
        { selectedBorder = "border-white"
        , selectedText = "text-white"
        , border = "border-grey-dark"
        , text = "text-grey-dark"
        , hoverBg = "bg-white"
        }
    }


getTheme : ColorMode -> Theme
getTheme colorMode =
    case colorMode of
        Dark ->
            darkTheme

        Light ->
            lightTheme


getStoryIdFromStories : ( String, Model a b c -> Html b, c ) -> String
getStoryIdFromStories ( s, _, _ ) =
    s


{-| Messages of the UI Explorer.
You should not interact with this Type unless you are trying to achieve more [advanced stuff](#Config) such as Plugin Creation.
-}
type Msg a
    = ExternalMsg a
    | SelectStory String
    | UrlChange Url.Url
    | LinkClicked Browser.UrlRequest
    | NoOp
    | MobileMenuToggled
    | ColorModeToggled



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


{-| Represents a family of related views.
For example using [Atomic Design](http://bradfrost.com/blog/post/atomic-web-design/), we can have the following categories : Atoms, Molecules etc..
-}
type UICategory a b c
    = UICategoryType (InternalUICategory a b c)


type alias InternalUICategory a b c =
    ( String, List (UI a b c) )


{-| The Config
-}
type alias UIViewConfig =
    { selectedUIId : Maybe String
    , selectedStoryId : Maybe String
    }


{-| Model of the UI Explorer.
You should not interact with this Type unless you are trying to achieve more [advanced stuff](#Config) such as Plugin Creation.
-}
type alias Model a b c =
    { categories : List (UICategory a b c)
    , selectedUIId : Maybe String
    , selectedStoryId : Maybe String
    , selectedCategory : Maybe String
    , url : Url.Url
    , key : Navigation.Key
    , customModel : a
    , mobileMenuIsOpen : Bool
    , colorMode : ColorMode
    }


{-| Use this type to change the logo whether using image url or a html element
-}
type Logo b
    = Logo (LogoType b)


type LogoType b
    = FromUrl String
    | FromHtml (Html (Msg b))


{-| Use this type to customize the appearance of the header

    config =
        { defaultConfig
            | customHeader =
                Just
                    { title = "This is my Design System"
                    , logo = UIExplorer.logoFromUrl "/some-fancy-logo.png"
                    , titleColor = Just "#FF6E00"
                    , bgColor = Just "#FFFFFF"
                    }
        }

-}
type alias CustomHeader b =
    { title : String
    , logo : Logo b
    , titleColor : Maybe String
    , bgColor : Maybe String
    }


{-| Configuration Type used to extend the UI Explorer appearance and behaviour.
-}
type alias Config a b c =
    { customModel : a
    , customHeader : Maybe (CustomHeader b)
    , update : b -> Model a b c -> ( Model a b c, Cmd b )
    , subscriptions : Model a b c -> Sub b
    , viewEnhancer : ViewEnhancer a b c
    , menuViewEnhancer : MenuViewEnhancer a b c
    }


{-| Sensible default configuration to initialize the explorer.
-}
defaultConfig : Config {} b c
defaultConfig =
    { customModel = {}
    , customHeader = Nothing
    , update =
        \_ m -> ( m, Cmd.none )
    , subscriptions =
        \_ -> Sub.none
    , viewEnhancer = \_ stories -> stories
    , menuViewEnhancer = \_ v -> v
    }


fragmentToArray : String -> Array String
fragmentToArray fragment =
    fragment
        |> String.split "/"
        |> Array.fromList
        |> Array.map (Url.percentDecode >> Maybe.withDefault "")


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
join =
    Maybe.andThen identity


{-| Get the Current Selected Story.
Usefull to retrieve the current selected story. It can be used with MenuViewEnhancer or ViewEnhancer to hide/display contextual content.
-}
getCurrentSelectedStory : Model a b c -> Maybe (Story a b c)
getCurrentSelectedStory { selectedUIId, selectedStoryId, categories } =
    Maybe.map2 (\a b -> ( a, b )) selectedUIId selectedStoryId
        |> Maybe.map (\( a, b ) -> findStory a b categories)
        |> join


{-| Find story
-}
findStory : String -> String -> List (UICategory a b c) -> Maybe (Story a b c)
findStory uiId storyId categories =
    let
        foundStory =
            List.map
                (\(UICategoryType ( _, b )) -> b)
                categories
                |> List.concat
                |> List.filter (\(UIType ui) -> ui.id == uiId)
                |> List.map (\(UIType ui) -> ui.viewStories)
                |> List.concat
                |> List.filter (\s -> (s |> getStoryIdFromStories) == storyId)
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
                ( newModel, subCmd ) =
                    config.update subMsg model
            in
            ( newModel, Cmd.map ExternalMsg subCmd )

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

        MobileMenuToggled ->
            ( { model | mobileMenuIsOpen = not model.mobileMenuIsOpen }, Cmd.none )

        ColorModeToggled ->
            ( { model
                | colorMode =
                    case model.colorMode of
                        Dark ->
                            Light

                        Light ->
                            Dark
              }
            , Cmd.none
            )



{--
toCategories : List (InternalUICategory a b c) -> List (UICategory a b c)
toCategories list =
    List.map UICategoryType list
--}


{-| Creates an empty list of UI Categories
-}
createCategories : List (UICategory a b c)
createCategories =
    []


{-| Create a UI given an ID and stories

    storiesOf
        "GreatUI"
        [ ( "Default", \_ -> GreatUI.view, {} )
        , ( "Loading", \_ -> GreatUI.viewLoading, {} )
        , ( "Failure", \_ -> GreatUI.viewFailure, {} )
        ]

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
    createCategories |> List.append [ UICategoryType ( "Default", uiList ) ]


{-| Adds a UI Category to a list of categories.
Convenient for running a UI Explorer devided into categories

       createCategories
            |> category "A Great Category"
                [ storiesOf
                    "GreatUI"
                    [ ( "SomeState", \_ -> GreatUI.view , {} ) ]
                ]

-}
category : String -> List (UI a b c) -> List (UICategory a b c) -> List (UICategory a b c)
category title uiList categories =
    let
        cat =
            UICategoryType
                ( title
                , uiList
                )
    in
    List.append categories [ cat ]


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
init customModel categories _ url key =
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
      , mobileMenuIsOpen = False
      , colorMode = Light
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
                    [ viewMobileOverlay model.mobileMenuIsOpen
                    , viewMobileMenu model model.mobileMenuIsOpen
                    , view config model
                    ]
                }
        , update = update config
        , onUrlChange = UrlChange
        , onUrlRequest = LinkClicked
        , subscriptions = \model -> Sub.map ExternalMsg (config.subscriptions model)
        }


{-| Launches a UI Explorer Applicaton given a list of [UI](#UI).
This is the simplest way to initialize the UI Explorer app.

Here we have an example of a Button that we want to explore:

    import UIExplorer exposing (UIExplorerProgram, defaultConfig, explore, storiesOf)

    button : String -> String -> Html.Html msg
    button label bgColor =
        Html.button
            [ style "background-color" bgColor ]
            [ Html.text label ]

    main : UIExplorerProgram {} () {}
    main =
        explore
            defaultConfig
            [ storiesOf
                "Button"
                [ ( "SignIn", \_ -> button "Sign In" "pink", {} )
                , ( "SignOut", \_ -> button "Sign Out" "cyan", {} )
                , ( "Loading", \_ -> button "Loading please wait..." "white", {} )
                ]
            ]

-}
explore : Config a b c -> List (UI a b c) -> UIExplorerProgram a b c
explore config uiList =
    app config (fromUIList uiList)


{-| Explore with Categories

Launches a UI Explorer Applicaton given a list of [UI Categories](#UICategory).
This is a more advanced way to initialize the UI Explorer app. It can be usefull if you want
to organize your UI by family.

    main : UIExplorerProgram {} () {}
    main =
        exploreWithCategories
            defaultConfig
            (createCategories
                |> category "Getting Started"
                    [ storiesOf
                        "About"
                        [ ( "About", \_ -> Docs.toMarkdown Docs.about, { hasMenu = False } ) ]
                    ]
                |> category
                    "Guidelines"
                    [ storiesOf
                        "Principles"
                        [ ( "Principles", \_ -> Docs.toMarkdown Docs.principles, { hasMenu = False } ) ]
                    ]
                |> category
                    "Styles"
                    [ storiesOf
                        "Colors"
                        [ ( "Brand", \_ -> ColorGuide.viewBrandColors, { hasMenu = True } )
                        , ( "Neutral", \_ -> ColorGuide.viewNeutralColors, { hasMenu = True } )
                        ]
                    , storiesOf
                        "Typography"
                        [ ( "Typography", \_ -> TypographyGuide.view, { hasMenu = False } )
                        ]
                    ]
            )
            defaultConfig

-}
exploreWithCategories : Config a b c -> List (UICategory a b c) -> UIExplorerProgram a b c
exploreWithCategories config categories =
    app config categories



{--VIEW --}


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
        theme =
            getTheme model.colorMode

        viewConfig =
            { selectedStoryId = model.selectedStoryId
            , selectedUIId = model.selectedUIId
            }
    in
    viewMenu theme model.categories viewConfig


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
        [ "p-0", "pb-2", "text-white", "shadow-md", "flex" ]
    , title =
        [ "font-normal", "text-3xl", "text-black" ]
    , subTitle =
        [ "font-normal", "text-3xl", "text-grey" ]
    }


viewToggleMobileMenu : Theme -> Html (Msg a)
viewToggleMobileMenu theme =
    div
        [ class "uie-block md:uie-hidden uie-flex uie-flex-col uie-justify-center uie-items-end uie-mr-4"
        ]
        [ button [ class ("uie-" ++ theme.iconColor), onClick MobileMenuToggled ]
            [ FeatherIcons.menu
                |> FeatherIcons.withSize 22
                |> FeatherIcons.toHtml []
            ]
        ]


viewToggleDarkMode : ColorMode -> Theme -> Html (Msg a)
viewToggleDarkMode colorMode theme =
    let
        icon =
            case colorMode of
                Dark ->
                    FeatherIcons.sun

                Light ->
                    FeatherIcons.moon
    in
    div
        [ class "uie-flex uie-flex-1 uie-flex-col uie-justify-center  uie-items-end uie-mr-4"
        ]
        [ button [ class ("uie-" ++ theme.iconColor), onClick ColorModeToggled ]
            [ icon
                |> FeatherIcons.withSize 22
                |> FeatherIcons.toHtml []
            ]
        ]


viewActionButtons : ColorMode -> Theme -> Html (Msg a)
viewActionButtons colorMode theme =
    div [ class "uie-flex  uie-flex-1" ]
        [ viewToggleDarkMode colorMode theme, viewToggleMobileMenu theme ]


viewHeader : ColorMode -> Theme -> Maybe (CustomHeader b) -> Html (Msg b)
viewHeader colorMode theme customHeader =
    case customHeader of
        Just { title, logo, titleColor, bgColor } ->
            let
                heightStyle =
                    style "height" "80px"

                titleStyles =
                    titleColor |> Maybe.map (\c -> [ style "color" c ]) |> Maybe.withDefault []

                headerStyles =
                    bgColor |> Maybe.map (\c -> [ style "background-color" c ]) |> Maybe.withDefault [ toClassName [ theme.headerColor ] ]

                viewLogo =
                    case logo of
                        Logo (FromUrl logoUrl) ->
                            img [ src logoUrl, heightStyle ] []

                        Logo (FromHtml viewCustom) ->
                            viewCustom
            in
            header
                ([ toClassName styleHeader.header
                 , heightStyle
                 ]
                    |> List.append headerStyles
                )
                [ viewLogo
                , div
                    [ toClassName [ "flex", "flex-col", "justify-center" ], heightStyle ]
                    [ h3 ([ classList [ ( "md:uie-ml-4", True ) ] ] |> List.append titleStyles) [ text title ]
                    ]
                , viewActionButtons colorMode theme
                ]

        Nothing ->
            let
                heightStyle =
                    style "height" "86px"
            in
            header
                ([ toClassName styleHeader.header, heightStyle ]
                    |> List.append
                        [ toClassName
                            [ theme.headerColor
                            , "border-grey-darker"
                            , "border-b"
                            , "pb-3"
                            ]
                        ]
                )
                [ div
                    ([ toClassName [ "bg-cover", "cursor-default", "logo" ]
                     ]
                        ++ (case colorMode of
                                Dark ->
                                    []

                                Light ->
                                    [ style "filter" "invert(1)" ]
                           )
                    )
                    []
                , viewActionButtons colorMode theme
                ]


styleMenuItem : Theme -> Bool -> List String
styleMenuItem { primaryTextColor, menu } isSelected =
    let
        defaultClass =
            [ "w-full"
            , "flex"
            , "pl-6"
            , "pt-2"
            , "pb-2"
            , "text-xs"
            , "no-underline"
            , hover menu.hoverBg
            , hover menu.hoverText
            ]
    in
    if isSelected then
        defaultClass
            |> List.append
                [ "selected", menu.text, menu.selectedBg ]

    else
        defaultClass
            |> List.append
                [ primaryTextColor ]


viewMenuItem : Theme -> String -> Maybe String -> UI a b c -> Html (Msg b)
viewMenuItem theme cat selectedUIId (UIType ui) =
    let
        defaultLink =
            case ui.viewStories |> List.head of
                Just story ->
                    "#" ++ cat ++ "/" ++ ui.id ++ "/" ++ getStoryIdFromStories story

                Nothing ->
                    "#" ++ cat ++ "/" ++ ui.id

        isSelected =
            selectedUIId
                |> Maybe.map ((==) ui.id)
                |> Maybe.withDefault False

        linkClass =
            styleMenuItem theme isSelected
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
    , "font-bold"
    , "w-full"
    , "flex"
    , "cursor-default"
    , "pl-4"
    , "pb-2"
    , "pt-2"
    , "text-sm"
    , "no-underline"
    ]


viewMenuCategory : Theme -> UIViewConfig -> UICategory a b c -> Html (Msg b)
viewMenuCategory theme { selectedUIId } (UICategoryType ( title, categories )) =
    div [ toClassName [] ]
        [ span
            [ toClassName styleMenuCategoryLink
            ]
            [ span [ toClassName [ "font-bold", theme.primaryTextColor, "text-sm" ] ] [ text title ] ]
        , ul [ toClassName [ "list-reset", "main-menu" ] ]
            (List.map (viewMenuItem theme title selectedUIId) categories)
        ]


viewMenu : Theme -> List (UICategory a b c) -> UIViewConfig -> Html (Msg b)
viewMenu theme categories config =
    aside
        [ toClassName
            [ "mt-8" ]
        ]
        (List.map (viewMenuCategory theme config) categories)


filterSelectedUI : UI a b c -> Model a b c -> Bool
filterSelectedUI (UIType ui) model =
    Maybe.map (\id -> ui.id == id) model.selectedUIId
        |> Maybe.withDefault False


getUIListFromCategories : UICategory a b c -> List (UI a b c)
getUIListFromCategories (UICategoryType ( _, categories )) =
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

        theme =
            getTheme model.colorMode
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
                            , theme.primaryTextColor
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



{--
oneThird : String
oneThird =
    "w-1/3"
--}


oneQuarter : String
oneQuarter =
    "w-1/4"


viewMobileMenu model isOpen =
    let
        theme =
            getTheme model.colorMode
    in
    div
        [ classList
            [ ( "uie-" ++ theme.sidebar.background, True )
            , ( "uie-h-full", True )
            , ( "uie-w-48", True )
            , ( "uie-absolute", True )
            , ( "uie-block", True )
            , ( "md:uie-hidden", True )
            , ( "uie-z-50", True )
            , ( "uie-overflow-y-auto", True )
            , ( "uie-border-r", True )
            , ( theme.sidebar.borderColor, True )
            ]
        , onClick MobileMenuToggled
        , if isOpen then
            style "transform" "translate(0%)"

          else
            style "transform" "translate(-100%)"
        , style "transition" "transform 0.3s ease-out"
        ]
        [ viewSidebar model ]


viewMobileOverlay isOpen =
    div
        [ classList
            [ ( "uie-bg-grey-darkest", True )
            , ( "uie-h-full", True )
            , ( "uie-w-full", True )
            , ( "uie-absolute", True )
            , ( "uie-opacity-75", True )
            , ( "uie-block", True )
            , ( "md:uie-hidden", True )
            , ( "uie-z-40", True )
            , ( "uie-visible", isOpen )
            , ( "uie-invisible", not isOpen )
            ]
        , onClick MobileMenuToggled
        ]
        []


view : Config a b c -> Model a b c -> Html (Msg b)
view config model =
    let
        theme =
            getTheme model.colorMode
    in
    div [ toClassName [ "h-screen overflow-hidden" ] ]
        [ viewHeader model.colorMode theme config.customHeader
        , div [ toClassName [ "flex" ] ]
            [ div
                [ toClassName
                    [ oneQuarter
                    , theme.sidebar.background
                    , theme.sidebar.borderColor
                    , "overflow-scroll"
                    , "sm:hidden"
                    ]
                , style
                    "height"
                    "calc(100vh - 86px)"
                , class "uie-hidden md:uie-block"
                ]
                [ viewSidebar model ]
            , div
                [ toClassName
                    [ "p-4"
                    , theme.primaryBgColor
                    , "w-screen"
                    , "h-screen"
                    , "overflow-scroll"
                    , "main-content"
                    ]
                ]
                [ viewContent config model ]
            ]
        ]


renderStory : Theme -> Int -> UIViewConfig -> ( String, a, c ) -> Html (Msg b)
renderStory { storyMenu, primaryBgColor } index { selectedStoryId } ( id, _, _ ) =
    let
        isActive =
            Maybe.map
                ((==) id)
                selectedStoryId
                |> Maybe.withDefault (index == 0)

        buttonClass =
            classList [ ( "", True ), ( "", isActive ) ]

        defaultLiClass =
            [ "mr-2"
            , "mb-2"
            , "rounded"
            , "p-2"
            , "text-xs"
            ]

        liClass =
            if isActive then
                [ "border"
                , storyMenu.selectedBorder
                , storyMenu.selectedText
                , "cursor-default"
                , "active"
                ]
                    |> List.append defaultLiClass

            else
                [ "border"
                , storyMenu.border
                , primaryBgColor
                , storyMenu.text
                , "cursor-pointer"
                , hover storyMenu.hoverBg
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

        theme =
            getTheme model.colorMode

        menu =
            config.menuViewEnhancer model (ul [ toClassName [ "flex-wrap", "list-reset", "flex", "mb-4" ] ] (List.indexedMap (\index -> renderStory theme index viewConfig) stories))

        currentStories =
            case selectedStoryId of
                Just selectedId ->
                    List.filter (\( id, _, _ ) -> id == selectedId) stories

                Nothing ->
                    stories

        content =
            case currentStories |> List.head of
                Just ( _, story, _ ) ->
                    story model |> Html.map ExternalMsg

                Nothing ->
                    text "Include somes states in your story..."
    in
    div []
        [ menu
        , div [] [ content ]
        ]


{-| Create a logo from a html element

Use this function to set the logo in the CustomHeader

-}
logoFromHtml : Html (Msg b) -> Logo b
logoFromHtml logo =
    Logo <| FromHtml logo


{-| Create a logo from a string

Use this function to set the logo in the CustomHeader

-}
logoFromUrl : String -> Logo b
logoFromUrl url =
    Logo <| FromUrl url
