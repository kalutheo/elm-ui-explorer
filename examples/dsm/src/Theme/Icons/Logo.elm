module Theme.Icons.Logo exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Svg exposing (clipPath, defs, g, path)
import Svg.Attributes exposing (color, d, fill, version, viewBox, x, y)


view : String -> Int -> Html msg
view c w =
    Html.node "svg-loader"
        [ attribute "url" "svg/logo.svg"
        , attribute "color" c
        , attribute "width" (String.fromInt w)
        ]
        []
