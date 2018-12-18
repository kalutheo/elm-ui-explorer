module Components.Text.View exposing (text)

import Color exposing (Color)
import Element exposing (..)
import Element.Font as Font
import Theme.Types exposing (ColorStyle, TypographyStyle)


text : String -> TypographyStyle -> ColorStyle -> Element msg
text label { family, size } { color } =
    let
        { red, green, blue } =
            Color.toRgba color
    in
    Element.paragraph
        [ Font.family
            [ Font.typeface family
            , Font.sansSerif
            ]
        , Font.size size
        , Font.color (rgb red green blue)
        ]
        [ Element.text label ]
