module Utils exposing (toRgb)

import Color as RawColor
import Element exposing (rgb)
import Theme.Color exposing (getColor)


toRgb : Theme.Color.Color -> Element.Color
toRgb c =
    let
        { red, green, blue } =
            c
                |> getColor
                |> RawColor.toRgba
    in
    rgb red green blue
