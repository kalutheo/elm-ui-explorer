module Button exposing (Appearance(..), Kind(..), Size(..), defaultConfig, view)

import Css exposing (..)
import Html
import Html.Styled exposing (..)


type alias Config =
    { appearance : Appearance
    , size : Size
    , kind : Kind
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
    | Phantom


defaultConfig : { appearance : Appearance, kind : Kind, size : Size }
defaultConfig =
    { appearance = Primary
    , size = M
    , kind = Filled
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
    if kind == Link then
        rgba 0 0 0 0

    else
        case appearance of
            Primary ->
                hex "00d1b2"

            Secondary ->
                hex "333333"


decoration : Kind -> List Style
decoration shape =
    case shape of
        Link ->
            [ textDecoration underline
            ]

        Filled ->
            [ textDecoration none
            ]

        Phantom ->
            [ textDecoration none
            ]


textColor : Appearance -> Kind -> Css.Color
textColor appearance kind =
    case kind of
        Link ->
            case appearance of
                Primary ->
                    hex "00d1b2"

                Secondary ->
                    hex "333333"

        Filled ->
            hex "FFFFFF"

        Phantom ->
            bgColor appearance kind


styledButton : Config -> List (Attribute msg) -> List (Html msg) -> Html msg
styledButton { appearance, size, kind } =
    styled button <|
        [ backgroundColor (bgColor appearance kind)
        , color (textColor appearance kind)
        , padding (Css.em 0.5)
        , fontSize (Css.em 0.9)
        , width (widthFromSize size)
        , height (Css.em 3)
        , borderRadius (Css.em 0.5)
        ]
            ++ decoration kind


view : String -> Config -> Html.Html msg
view label config =
    styledButton config [] [ text label ] |> toUnstyled
