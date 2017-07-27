module MainCss exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Css.Elements exposing (body)
import Html.CssHelpers exposing (withNamespace)
import Style.System exposing (colors, fonts, size)


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
        [ body
            []
        , class
            App
            [ backgroundColor colors.primary
            , color colors.light
            , fontFamilies fonts.primary
            , borderRadius (px 5)
            , boxShadow4 (px 5) (px 10) (px 20) (rgba 0 0 0 0.3)
            , overflow hidden
            , width size.artworkSize
            , height size.playerHeight
            ]
        , class Artwork
            [ width size.artworkSize
            , height size.artworkSize
            , backgroundSize cover
            , position relative
            ]
        , class Controls
            [ position absolute
            , color colors.light
            , bottom zero
            , left zero
            , width (pct 100)
            , displayFlex
            , height size.artworkSize
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
            , color colors.light
            , hover
                [ backgroundColor colors.selected
                , cursor pointer
                , color colors.warm
                , children
                    [ class TrackDuration [ property "opacity" "1" ]
                    ]
                ]
            ]
        , class TrackList
            [ width size.artworkSize
            , height (px 120)
            , backgroundColor colors.secondary
            , overflowY auto
            , padding zero
            ]
        , class TrackSelected
            [ backgroundColor colors.selected
            , cursor default
            , color colors.warm
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
