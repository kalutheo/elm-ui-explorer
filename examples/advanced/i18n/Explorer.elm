module Explorer exposing (main, stories)

import Browser
import Browser.Navigation as Navigation
import Dict
import DictSet
import Html exposing (Html, aside, button, div, li, span, text, ul)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import I18Next exposing (Translations, initialTranslations, t, translationsDecoder)
import Json.Decode
import Main
import UIExplorer exposing (Msg(..), UICategory, app, createUI, fromUIList, renderStories, view)
import Url


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


type Lang
    = Lang String


type alias Model =
    { url : Url.Url
    , key : Navigation.Key
    , explorer : UIExplorer.Model
    , translations : Translations
    , currentLang : Lang
    }



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



{--A simple wrapper to prevent description to be hidden by the dropdown --}


viewStoriesWrapper : Main.Model -> Html.Html Main.Msg
viewStoriesWrapper model =
    div [ style "height" "100px" ] [ Main.view model ]


categories translations =
    fromUIList
        [ createUI
            "dropdown"
            (renderStories viewStoriesWrapper (stories translations))
        ]


type Msg
    = UrlChange Url.Url
    | LinkClicked Browser.UrlRequest
    | ExlporerMsg UIExplorer.Msg
    | ChangeLang Lang


getTranslationsFromLang : Lang -> Translations
getTranslationsFromLang (Lang lang) =
    Dict.get lang translationLabels
        |> Maybe.map
            (Json.Decode.decodeString translationsDecoder
                >> Result.map identity
                >> Result.withDefault initialTranslations
            )
        |> Maybe.withDefault initialTranslations


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        defaultLang =
            Lang "En"

        translations =
            getTranslationsFromLang defaultLang
    in
    ( { url = url
      , key = key
      , explorer = UIExplorer.initModelFromUrl (categories translations) url key
      , translations = translations
      , currentLang = defaultLang
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

        ChangeLang lang ->
            let
                translations =
                    getTranslationsFromLang lang
            in
            ( { model
                | currentLang = lang
                , explorer = UIExplorer.initModelFromUrl (categories translations) model.url model.key
                , translations = translations
              }
            , Cmd.none
            )


languageButton : Bool -> ( String, String ) -> Html Msg
languageButton isSelected ( key, value ) =
    let
        title =
            Json.Decode.decodeString (Json.Decode.field "lang" Json.Decode.string) value
                |> Result.map identity
                |> Result.withDefault value

        textClass =
            if isSelected then
                "uie-text-purple-dark"

            else
                "uie-text-grey-dark"
    in
    li [ class "uie-text-xs " ]
        [ button [ style "outline" "none", class <| textClass ++ " uie-outline-none", onClick <| ChangeLang (Lang key) ] [ text title ]
        ]


languageSelector : Lang -> Html Msg
languageSelector (Lang currentLang) =
    let
        languages =
            translationLabels |> Dict.toList
    in
    div []
        [ span [ class "uie-mb-2 uie-pb-1 uie-block uie-border-grey-light uie-border-b uie-text-grey-darker" ] [ text "Choose language" ]
        , ul []
            (languages |> List.map (\l -> languageButton (currentLang == Tuple.first l) l))
        ]


pluginPanel model =
    aside
        [ class "uie-bg-grey-lighter uie-p-8 uie-h-full uie-absolute uie-pin-t uie-pin-r"
        , style "margin-top" "95px"
        , style "width" "220px"
        ]
        [ languageSelector model.currentLang ]


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view =
            \model ->
                { title = "My Storybook Elm :-)"
                , body =
                    [ Html.map ExlporerMsg (view model.explorer)
                    , pluginPanel model
                    ]
                }
        , update = update
        , onUrlChange = UrlChange
        , onUrlRequest = LinkClicked
        , subscriptions = \_ -> Sub.none
        }
