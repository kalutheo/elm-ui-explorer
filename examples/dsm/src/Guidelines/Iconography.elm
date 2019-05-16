module Guidelines.Iconography exposing (viewClassic, viewWithBg)

import Color as RawColor
import Components.Text.View as TextView
import Element exposing (..)
import Element.Background as Background
import Html exposing (div)
import Html.Attributes exposing (attribute, style)
import Svg exposing (svg, use)
import Svg.Attributes exposing (fill)
import Theme.Color exposing (Color, color, getColor)
import Theme.Icons.Icon as Icon exposing (Icon, Size(..), getName, icon)
import Theme.Typography exposing (typography)


iconsCollection : List Icon
iconsCollection =
    [ icon.pita, icon.salad, icon.frenchFries, icon.soda, icon.iceCream, icon.logo, icon.menu ]


viewIcon : Color -> Color -> Icon -> Element msg
viewIcon bgColor iconColor i =
    let
        { red, green, blue } =
            RawColor.toRgba (getColor bgColor)
    in
    Element.column [ spacing 8 ]
        [ Element.el [ Background.color <| rgb red green blue, padding 20 ] (Element.html <| Icon.view iconColor i S)
        , Element.el [ centerX ] (TextView.text typography.paragraph color.neutral.greyDarkest (getName i))
        ]


view : Color -> Color -> Html.Html msg
view bgColor iconColor =
    Element.layout [] <| Element.row [ spacing 12 ] (iconsCollection |> List.map (viewIcon bgColor iconColor))


viewWithBg : Html.Html msg
viewWithBg =
    view color.brand.secondary color.neutral.white


viewClassic : Html.Html msg
viewClassic =
    view color.neutral.white color.neutral.greyDarkest
