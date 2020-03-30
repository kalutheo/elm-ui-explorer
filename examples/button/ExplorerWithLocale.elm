module ExplorerWithLocale exposing (main)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import UIExplorer exposing (UIExplorerProgram, defaultConfig, explore, storiesOf)


type Locale
    = En
    | Fr
    | De


type Msg
    = ChangedLocale Locale


type alias Model =
    { locale : Locale }


initialModel : Model
initialModel =
    { locale = En }


button : String -> String -> Html.Html msg
button label bgColor =
    Html.button
        [ style "background-color" bgColor, style "padding" "10px" ]
        [ Html.text label ]


buttonLabel : Locale -> String
buttonLabel locale =
    case locale of
        En ->
            "confirm password"

        Fr ->
            "Confirmez le mot de passe"

        De ->
            "Kennwort bestätigen"


menuViewEnhancer : a -> Html (UIExplorer.Msg Msg) -> Html (UIExplorer.Msg Msg)
menuViewEnhancer model menuView =
    div []
        [ ul [ style "margin-bottom" "8px", style "font-size" "9px", style "display" "flex" ]
            [ li []
                [ Html.button [ onClick (UIExplorer.ExternalMsg <| ChangedLocale En) ] [ text "English" ]
                ]
            , li [ style "margin-left" "2px", style "margin-right" "2px" ] [ text "-" ]
            , li []
                [ Html.button [ onClick (UIExplorer.ExternalMsg <| ChangedLocale Fr) ] [ text "Français" ]
                ]
            , li [ style "margin-left" "2px", style "margin-right" "2px" ] [ text "-" ]
            , li []
                [ Html.button [ onClick (UIExplorer.ExternalMsg <| ChangedLocale De) ] [ text "Deutsch" ]
                ]
            ]
        , menuView
        ]


main : UIExplorerProgram Model Msg {}
main =
    explore
        { customModel = initialModel
        , customHeader = Nothing
        , update =
            \msg m ->
                case msg of
                    ChangedLocale locale ->
                        ( { m | customModel = { locale = locale } }, Cmd.none )
        , subscriptions =
            \m -> Sub.none
        , viewEnhancer = \m stories -> stories
        , menuViewEnhancer = menuViewEnhancer
        }
        [ storiesOf
            "Button"
            [ ( "Primary", \m -> button (buttonLabel m.customModel.locale) "pink", {} )
            , ( "Secondary", \m -> button (buttonLabel m.customModel.locale) "violet", {} )
            ]
        ]
