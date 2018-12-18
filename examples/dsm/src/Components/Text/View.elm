module Components.Text.View exposing (text)

import Color exposing (Color)
import Element exposing (..)
import Element.Font as Font
import Theme.Colors exposing (ColorStyle)
import Theme.Typography exposing (Typography, getFamily, getSize)


text : String -> Typography -> ColorStyle -> Element msg
text label typo { color } =
    let
        { red, green, blue } =
            Color.toRgba color
    in
    Element.paragraph
        [ Font.family
            [ Font.typeface (getFamily typo)
            , Font.sansSerif
            ]
        , Font.size (getSize typo)
        , Font.color (rgb red green blue)
        ]
        [ Element.text label ]
