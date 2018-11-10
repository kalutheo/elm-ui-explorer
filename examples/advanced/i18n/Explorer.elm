module Explorer exposing (main, stories)

import Browser
import Browser.Navigation as Navigation
import Dict
import DictSet
import Html exposing (Html, aside, button, div, li, span, text, ul)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import I18Next exposing (Translations, initialTranslations, t, translationsDecoder)
import I18nPlugin exposing (Lang, TranslationLabels)
import Json.Decode
import Main
import UIExplorer exposing (Msg(..), UICategory, app, createUI, createUIWithSnapshots, fromUIList, renderStories, view, viewPluginPanel)
import Url


type alias Model =
    { url : Url.Url
    , key : Navigation.Key
    , explorer : UIExplorer.Model Main.Model
    , i18n : I18nPlugin.State
    }


type Msg
    = UrlChange Url.Url
    | LinkClicked Browser.UrlRequest
    | ExlporerMsg UIExplorer.Msg
    | I18nMsg I18nPlugin.Msg


translationLabels : TranslationLabels
translationLabels =
    [ ( "En", """
        {
            "lang": "English",
            "labels": {
            "click-me": "Click Me"
            },
            "menu" : {
                "home": "Home",
                "about": "About us"
            }
        }
    """ )
    , ( "Fr", """
        {
            "lang": "Français",
            "labels": {
            "click-me": "Cliquez moi"
            },
            "menu" : {
                "home": "Accueil",
                "about": "A propos de nous"
            }
        }
    """ )
    , ( "De", """
        {
            "lang": "Deutsch",
            "labels": {
            "click-me": "Klick mich"
            },
            "menu" : {
                "home": "Anmeldefensters",
                "about": "Über uns"
            }
        }
    """ )
    ]
        |> Dict.fromList



{--A list of stories that represent all available states of the UI--}


stories : Translations -> List ( String, Main.Model )
stories translations =
    let
        entries =
            [ t translations "menu.home"
            , t translations "menu.about"
            ]

        title =
            t translations "labels.click-me"
    in
    [ ( "Default"
      , { isOpen = False
        , entries = entries
        , title = title
        }
      )
    , ( "Opened", { isOpen = True, entries = entries, title = title } )
    ]


categories translations =
    fromUIList
        [ createUIWithSnapshots
            "dropdown"
            ""
            Main.view
            (stories translations)
        ]


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        i18nState =
            I18nPlugin.init translationLabels
    in
    ( { url = url
      , key = key
      , explorer = UIExplorer.initModelFromUrl (categories i18nState.translations) url key
      , i18n = i18nState
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model
                | url = location
                , explorer = UIExplorer.changeUrl model.explorer location
              }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Navigation.load href )

        ExlporerMsg subMsg ->
            let
                ( updatedExplorerModel, explorerCmd ) =
                    UIExplorer.update subMsg model.explorer
            in
            ( { model | explorer = updatedExplorerModel }, Cmd.map ExlporerMsg explorerCmd )

        I18nMsg submsg ->
            let
                i18nState =
                    I18nPlugin.update translationLabels submsg model.i18n
            in
            ( { model
                | i18n = i18nState
                , explorer = UIExplorer.initModelFromUrl (categories i18nState.translations) model.url model.key
              }
            , Cmd.none
            )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view =
            \model ->
                { title = "Elm UI Explorer - i18n"
                , body =
                    [ Html.map ExlporerMsg (view model.explorer)
                    , viewPluginPanel [ Html.map I18nMsg (I18nPlugin.languageSelector translationLabels model.i18n.currentLang) ]
                    ]
                }
        , update = update
        , onUrlChange = UrlChange
        , onUrlRequest = LinkClicked
        , subscriptions = \_ -> Sub.none
        }
