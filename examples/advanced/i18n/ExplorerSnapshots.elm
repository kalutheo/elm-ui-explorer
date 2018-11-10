port module ExplorerSnapshots exposing (main)

import Dict
import I18Next exposing (Translations, initialTranslations, t, translationsDecoder)
import I18nPlugin exposing (TranslationLabels)
import Main exposing (view)
import Platform
import UIExplorer exposing (Msg(..), UICategory, app, createUI, createUIWithSnapshots, fromUIList, renderStories, view, viewPluginPanel)


type alias Model =
    {}


type Msg
    = No0p


r =
    Debug.log "Hello i am a worker :-)"


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


categories translations =
    fromUIList
        [ createUIWithSnapshots
            "dropdown"
            ""
            Main.view
            (stories translations)
        ]


init : () -> ( Model, Cmd Msg )
init flags =
    let
        i18nState =
            I18nPlugin.init translationLabels

        _ =
            Debug.log "l" (categories i18nState.translations)
    in
    ( {}
    , Cmd.none
    )


main : Program () Model Msg
main =
    Platform.worker
        { init = init
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }
