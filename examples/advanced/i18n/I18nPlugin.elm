module I18nPlugin exposing (Lang, Msg, State, TranslationLabels, getTranslationsFromLang, init, languageButton, languageSelector, update)

import Dict
import Html exposing (Html, button, div, li, span, text, ul)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import I18Next exposing (Translations, initialTranslations, t, translationsDecoder)
import Json.Decode


type alias TranslationLabels =
    Dict.Dict String String


type Lang
    = Lang String


type Msg
    = ChangeLang Lang


type alias State =
    { translations : Translations
    , currentLang : Lang
    }


init : TranslationLabels -> State
init translationLabels =
    let
        defaultLang =
            Lang "En"

        translations =
            getTranslationsFromLang translationLabels defaultLang
    in
    { translations = translations
    , currentLang = defaultLang
    }


getTranslationsFromLang : TranslationLabels -> Lang -> Translations
getTranslationsFromLang translationLabels (Lang lang) =
    Dict.get lang translationLabels
        |> Maybe.map
            (Json.Decode.decodeString translationsDecoder
                >> Result.map identity
                >> Result.withDefault initialTranslations
            )
        |> Maybe.withDefault initialTranslations


update : TranslationLabels -> Msg -> State -> State
update translationLabels msg state =
    case msg of
        ChangeLang lang ->
            let
                translations =
                    getTranslationsFromLang translationLabels lang
            in
            { state
                | currentLang = lang
                , translations = translations
            }


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


languageSelector : TranslationLabels -> Lang -> Html Msg
languageSelector translationLabels (Lang currentLang) =
    let
        languages =
            translationLabels |> Dict.toList
    in
    div []
        [ span [ class "uie-mb-2 uie-pb-1 uie-block uie-border-grey-light uie-border-b uie-text-grey-darker" ]
            [ text "Choose language"
            ]
        , ul []
            (languages |> List.map (\l -> languageButton (currentLang == Tuple.first l) l))
        ]
