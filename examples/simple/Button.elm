module Button exposing (Appearance(..), Kind(..), Size(..), defaultConfig, view)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class)
import Html.Styled.Events exposing (onClick)


type alias Config =
    { appearance : Appearance
    , size : Size
    , kind : Kind
    , class : String
    }


type Appearance
    = Primary
    | Secondary


type Size
    = S
    | M
    | L


type Kind
    = Link
    | Filled
    | Ghost


defaultConfig : Config
defaultConfig =
    { appearance = Primary
    , size = M
    , kind = Filled
    , class = ""
    }


widthFromSize : Size -> Css.Em
widthFromSize size =
    case size of
        S ->
            Css.em 5

        M ->
            Css.em 8

        L ->
            Css.em 16


bgColor : Appearance -> Kind -> Css.Color
bgColor appearance kind =
    if kind == Link || kind == Ghost then
        rgba 0 0 0 0

    else
        colorFromAppearance appearance


decoration : Kind -> List Style
decoration shape =
    case shape of
        Link ->
            [ textDecoration underline
            ]

        Filled ->
            [ textDecoration none
            ]

        Ghost ->
            [ textDecoration none
            ]


colorFromAppearance : Appearance -> Css.Color
colorFromAppearance appearance =
    case appearance of
        Primary ->
            hex "00d1b2"

        Secondary ->
            hex "333333"


textColor : Appearance -> Kind -> Css.Color
textColor appearance kind =
    case kind of
        Link ->
            colorFromAppearance appearance

        Filled ->
            hex "FFFFFF"

        Ghost ->
            colorFromAppearance appearance


styledButton : Config -> List (Attribute msg) -> List (Html msg) -> Html msg
styledButton { appearance, size, kind } =
    styled button <|
        [ backgroundColor (bgColor appearance kind)
        , border <|
            if kind == Ghost then
                px 1

            else
                px 0
        , borderStyle solid
        , borderColor (colorFromAppearance appearance)
        , color (textColor appearance kind)
        , padding (Css.em 0)
        , fontSize (Css.em 0.9)
        , width (widthFromSize size)
        , height (Css.em 3)
        , borderRadius (Css.em 0.5)
        , important (outline none)
        ]
            ++ decoration kind


view : String -> Config -> msg -> Html.Html msg
view label config clickMsg =
    styledButton config [ onClick clickMsg, class config.class ] [ text label ] |> toUnstyled
