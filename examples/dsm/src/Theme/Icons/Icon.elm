module Theme.Icons.Icon exposing (IconType(..), view)

import Color as RawColor
import Html exposing (Html, div)
import Theme.Color exposing (Color, color, getColor)
import Theme.Icons.Pita as PitaIcon
import Theme.Icons.Salad as SaladIcon


type IconType
    = Salad
    | Pita


view : IconType -> Color -> Html msg
view icon color =
    let
        c =
            RawColor.toCssString (getColor color)
    in
    case icon of
        Salad ->
            SaladIcon.view c

        Pita ->
            PitaIcon.view c
