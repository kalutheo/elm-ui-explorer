module MainCss exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


type CssClasses
    = App
    | Artwork
    | Controls
    | ControlIcon
    | TrackItem
    | TrackList
    | TrackSelected
    | TrackNumber
    | TrackTitle
    | TrackDuration


appNameSpace : Html.CssHelpers.Namespace String class id msg
appNameSpace =
    withNamespace "musicPlayer"


css : Stylesheet
css =
    (stylesheet << namespace appNameSpace.name)
        [ class App
            [ borderRadius (px 5)
            , boxShadow4 (px 5) (px 10) (px 20) (rgba 0 0 0 0.3)
            , overflow hidden
            , width (px 280)
            , height (px 400)
            ]
        , class Artwork
            [ width (px 280)
            , height (px 280)
            , backgroundSize cover
            , position relative
            ]
        , class Controls
            [ position absolute
            , bottom zero
            , left zero
            , width (pct 100)
            , displayFlex
            , height (px 280)
            , boxSizing borderBox
            , backgroundColor (rgba 41 23 32 0.3)
            , justifyContent spaceAround
            , padding2 (px 20) (px 0)
            , alignItems center
            , property "transition" "background .125s ease"
            , hover
                [ backgroundColor (rgba 41 23 32 0.8)
                ]
            ]
        , class ControlIcon
            [ property "transform" "scale(2)"
            , cursor pointer
            ]
        , class TrackItem
            [ displayFlex
            , padding (px 10)
            , boxSizing borderBox
            , borderBottom3 (px 1) solid (rgba 255 255 255 0.1)
            , fontSize (px 11)
            , textTransform uppercase
            , fontWeight (int 300)
            , cursor pointer
            , hover
                [ backgroundColor (hex "#39202d")
                , cursor pointer
                , color (hex "#d90368")
                , children
                    [ class TrackDuration [ property "opacity" "1" ]
                    ]
                ]
            ]
        , class TrackList
            [ width (px 280)
            , height (px 120)
            , backgroundColor (hex "#4a293a")
            , overflowY auto
            , padding zero
            ]
        , class TrackSelected
            [ backgroundColor (hex "#39202d")
            , cursor default
            , color (hex "#d90368")
            , children
                [ class TrackDuration [ property "opacity" "1" ]
                ]
            ]
        , class TrackTitle
            [ marginLeft (px 10)
            , property "fontWeight" "500"
            , letterSpacing (em 0.12)
            ]
        , class TrackDuration
            [ marginLeft auto
            , property "opacity" "0.25"
            ]
        ]
