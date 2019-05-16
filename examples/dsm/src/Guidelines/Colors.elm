module Guidelines.Colors exposing (viewBrandColors, viewNeutralColors)

import Color as RawColor
import Color.Convert exposing (colorToHex)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Theme.Color as ThemeColor exposing (Color, color, getColor, getColorName)


brandColorCollection : List Color
brandColorCollection =
    [ color.brand.primary
    , color.brand.secondary
    , color.brand.secondaryVariant
    , color.brand.alternative
    ]


neutralColorCollection : List Color
neutralColorCollection =
    [ color.neutral.white
    , color.neutral.greyLightest
    , color.neutral.greyLighter
    , color.neutral.greyLight
    , color.neutral.grey
    , color.neutral.greyDark
    , color.neutral.greyDarker
    , color.neutral.greyDarkest
    , color.neutral.black
    ]


boxWidth : number
boxWidth =
    120


viewColor : Color -> Element msg
viewColor color =
    let
        { red, green, blue } =
            RawColor.toRgba (getColor color)

        b =
            RawColor.toRgba (getColor ThemeColor.color.neutral.greyLightest)
    in
    Element.column []
        [ Element.column [ spacing 8 ]
            [ Element.row
                [ Background.color <| rgb red green blue
                , Element.width (px boxWidth)
                , Element.height (px boxWidth)
                , Border.solid
                , Border.width 1
                , Border.color <| rgb b.red b.green b.blue
                ]
                []
            , Element.column [ spacing 2 ]
                [ Element.row
                    [ Font.size 13
                    ]
                    [ Element.text (getColorName color) ]
                , Element.row
                    [ Font.size 12
                    , Font.color <| rgb255 102 102 102
                    ]
                    [ Element.text <| colorToHex (getColor color)
                    ]
                ]
            ]
        ]


viewBrandColors : Html msg
viewBrandColors =
    Element.layout [] <| Element.wrappedRow [ spacing 8 ] (brandColorCollection |> List.map viewColor)


viewNeutralColors : Html msg
viewNeutralColors =
    Element.layout [] <| Element.wrappedRow [ spacing 8, Element.width (px 800) ] (neutralColorCollection |> List.map viewColor)
