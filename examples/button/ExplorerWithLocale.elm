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


localButtonView : msg -> String -> Html (UIExplorer.Msg msg)
localButtonView onClickMsg label =
    li
        [ style "font-size" "11px"
        , style "margin-right" "8px"
        ]
        [ Html.button
            [ onClick (UIExplorer.ExternalMsg <| onClickMsg)
            , style "color" "#666"
            ]
            [ text label ]
        ]


menuViewEnhancer : a -> Html (UIExplorer.Msg Msg) -> Html (UIExplorer.Msg Msg)
menuViewEnhancer _ menuView =
    div []
        [ ul
            [ style "margin-bottom" "8px"
            , style "font-size" "9px"
            , style "display" "flex"
            , style "list-style" "none"
            , style "padding" "0px"
            ]
            [ localButtonView (ChangedLocale En) "English"
            , localButtonView (ChangedLocale Fr) "Français"
            , localButtonView (ChangedLocale De) "Deutsch"
            ]
        , menuView
        ]


main : UIExplorerProgram Model Msg {}
main =
    explore
        { customModel = initialModel
        , customHeader = Nothing
        , customTitle = "UI Explorer With Locale"
        , update =
            \msg m ->
                case msg of
                    ChangedLocale locale ->
                        ( { m | customModel = { locale = locale } }, Cmd.none )
        , subscriptions =
            \m -> Sub.none
        , viewEnhancer = \m stories -> stories
        , menuViewEnhancer = menuViewEnhancer
        , onModeChanged = Nothing
        }
        [ storiesOf
            "Button"
            [ ( "Primary", \m -> button (buttonLabel m.customModel.locale) "pink", {} )
            , ( "Secondary", \m -> button (buttonLabel m.customModel.locale) "violet", {} )
            ]
        ]
