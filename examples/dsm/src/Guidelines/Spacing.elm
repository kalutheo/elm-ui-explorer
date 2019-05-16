module Guidelines.Spacing exposing (view)

import Color as RawColor
import Components.Text.View as TextView
import Element exposing (..)
import Element.Background as Background
import Html
import Theme.Color exposing (Color, color, getColor)
import Theme.Spacing exposing (..)
import Theme.Typography exposing (..)


spacingCollection : List SpacingStyle
spacingCollection =
    [ smallest
    , small
    , medium
    , large
    , extraLarge
    , largest
    ]


viewSpacing : SpacingStyle -> Element msg
viewSpacing s =
    let
        { red, green, blue } =
            RawColor.toRgba (getColor color.brand.primary)
    in
    Element.row [ Element.spacing large.value ]
        [ Element.row [ width (px 100) ] [ TextView.text typography.paragraph color.neutral.greyDark s.name ]
        , Element.row
            [ Background.color <| rgb red green blue
            , padding 0
            , width
                (px s.value)
            , height (px s.value)
            ]
            []
        ]


view : Html.Html msg
view =
    Element.layout [] <| Element.column [ Element.spacing large.value ] (spacingCollection |> List.map viewSpacing)
