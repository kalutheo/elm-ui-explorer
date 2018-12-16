module Guidelines.Colors exposing (viewBrandColors, viewNeutralColors)

import Color exposing (Color)
import Color.Convert exposing (colorToHex)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Theme exposing (brandColorCollection, neutralColorCollection)
import Theme.Colors exposing (colors)
import Theme.Types exposing (ColorStyle)


boxWidth =
    180


viewColor : ColorStyle -> Element msg
viewColor { color, name } =
    let
        { red, green, blue } =
            Color.toRgba color

        b =
            Color.toRgba colors.neutral.greyLightest.color
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
                    [ Font.size 14
                    ]
                    [ Element.text name ]
                , Element.row
                    [ Font.size 14
                    , Font.color <| rgb255 102 102 102
                    ]
                    [ Element.text <| colorToHex color
                    ]
                ]
            ]
        ]


viewBrandColors =
    Element.layout [] <| Element.wrappedRow [ spacing 8 ] (brandColorCollection |> List.map viewColor)


viewNeutralColors =
    Element.layout [] <| Element.wrappedRow [ spacing 8, Element.width (px 800) ] (neutralColorCollection |> List.map viewColor)
