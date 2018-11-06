module Explorer exposing (main, stories)

import Browser
import Browser.Navigation as Navigation
import Html exposing (button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import I18Next exposing (Translations, initialTranslations, t, translationsDecoder)
import Json.Decode
import Main
import UIExplorer exposing (Msg(..), UICategory, app, createUI, fromUIList, renderStories, view)
import Url


englishLabels =
    """
        {
            "labels": {
            "click-me": "Click Me"
            },
            "menu" : {
                "home": "Home",
                "about": "About us"
            }
        }
    """


frenchLabels =
    """
        {
            "labels": {
            "click-me": "Cliquez moi"
            },
            "menu" : {
                "home": "Accueil",
                "about": "A propos de nous"
            }
        }
    """


type Lang
    = En
    | Fr


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
    in
    [ ( "Default"
      , { isOpen = False
        , entries = entries
        }
      )
    , ( "Opened", { isOpen = True, entries = entries } )
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
getTranslationsFromLang lang =
    (case lang of
        En ->
            Json.Decode.decodeString translationsDecoder englishLabels

        Fr ->
            Json.Decode.decodeString translationsDecoder frenchLabels
    )
        |> Result.map identity
        |> Result.withDefault initialTranslations


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        defaultLang =
            En

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


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view =
            \model ->
                { title = "My Storybook Elm :-)"
                , body =
                    [ Html.map ExlporerMsg (view model.explorer)
                    , button [ onClick <| ChangeLang Fr ] [ text "French" ]
                    , button [ onClick <| ChangeLang En ] [ text "English" ]
                    ]
                }
        , update = update
        , onUrlChange = UrlChange
        , onUrlRequest = LinkClicked
        , subscriptions = \_ -> Sub.none
        }
