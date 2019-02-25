module Components.Text.View exposing (text)

import Color as RawColor
import Element exposing (..)
import Element.Font as Font
import Theme.Color exposing (Color, getColor)
import Theme.Typography exposing (FontWeight(..), Typography, getFamily, getLetterspacing, getSize, getWeight)


text : Typography -> Color -> String -> Element msg
text typo color label =
    let
        { red, green, blue } =
            RawColor.toRgba (getColor color)
    in
    Element.paragraph
        [ Font.family
            [ Font.typeface (getFamily typo)
            , Font.sansSerif
            ]
        , Font.size (getSize typo)
        , Font.color (rgb red green blue)
        , Font.letterSpacing (getLetterspacing typo)
        , if getWeight typo == Bold then
            Font.bold

          else
            Font.regular
        ]
        [ Element.text label ]
