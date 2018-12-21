module Theme.Icons.Icon exposing (Icon, getName, icon, view)

import Color as RawColor
import Html exposing (Html, div)
import Theme.Color exposing (Color, color, getColor)
import Theme.Icons.Pita as PitaIcon
import Theme.Icons.Salad as SaladIcon


type alias IconStyle =
    { name : String }


type Icon
    = Salad IconStyle
    | Pita IconStyle


type alias IconTheme =
    { pita : Icon
    , salad : Icon
    }


icon : IconTheme
icon =
    { salad =
        Salad
            { name = "Salad"
            }
    , pita =
        Pita
            { name = "Pita"
            }
    }


getName : Icon -> String
getName i =
    case i of
        Salad v ->
            v.name

        Pita v ->
            v.name


view : Color -> Icon -> Html msg
view color i =
    let
        c =
            RawColor.toCssString (getColor color)
    in
    case i of
        Salad _ ->
            SaladIcon.view c

        Pita _ ->
            PitaIcon.view c
