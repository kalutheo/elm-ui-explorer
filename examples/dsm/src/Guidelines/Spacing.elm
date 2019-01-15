module Guidelines.Spacing exposing (view)

import Color as RawColor
import Element exposing (..)
import Element.Background as Background
import Html
import Theme.Color exposing (Color, color, getColor)
import Theme.Spacing exposing (..)


spacingCollection : List Int
spacingCollection =
    [ smallest.value
    , small.value
    , medium.value
    , large.value
    , extraLarge.value
    , largest.value
    ]


viewSpacing : Int -> Element msg
viewSpacing int =
    let
        { red, green, blue } =
            RawColor.toRgba (getColor color.brand.primary)
    in
    Element.row
        [ Background.color <| rgb red green blue
        , padding 0
        , width
            (px int)
        , height (px int)
        ]
        []


view : Html.Html msg
view =
    Element.layout [] <| Element.row [ Element.spacing 8 ] (spacingCollection |> List.map viewSpacing)
