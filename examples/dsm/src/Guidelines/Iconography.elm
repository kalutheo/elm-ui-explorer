module Guidelines.Iconography exposing (view)

import Color as RawColor
import Html exposing (div)
import Html.Attributes exposing (attribute, style)
import Svg exposing (svg, use)
import Svg.Attributes exposing (fill)
import Theme.Color exposing (Color, color, getColor)
import Theme.Icons.Icon as Icon exposing (IconType(..))


view : Html.Html msg
view =
    div []
        [ div [] [ Icon.view Pita color.brand.primary ]
        , div [] [ Icon.view Salad color.brand.secondaryVariant ]
        ]
