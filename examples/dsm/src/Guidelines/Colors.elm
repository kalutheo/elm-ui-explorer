module Guidelines.Colors exposing (view)

import Color exposing (Color)
import Color.Convert exposing (colorToHex)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)
import System exposing (ColorStyle)


width =
    180


viewColor : ColorStyle -> Element msg
viewColor { color, name } =
    let
        { red, green, blue } =
            Color.toRgba color
    in
    Element.column []
        [ Element.column [ spacing 8 ]
            [ Element.row
                [ Background.color <| rgb red green blue
                , Element.width (px width)
                , Element.height (px width)
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


view : Html msg
view =
    Element.layout [] <| Element.row [ spacing 10 ] (System.colors |> List.map viewColor)
