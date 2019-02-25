module Components.Block.Welcome.View exposing (view)

import Color exposing (toRgba)
import Color.Convert exposing (colorToHex)
import Components.Button.View as Button exposing (defaultButtonConfig)
import Components.Text.View as Text
import Css
import Element exposing (..)
import Element.Background as Background
import Html exposing (text)
import Theme.Color exposing (..)
import Theme.Spacing exposing (..)
import Theme.Typography exposing (..)


block : Theme.Color.Color -> Element ()
block c =
    let
        { red, green, blue } =
            toRgba (getColor c)
    in
    Element.row
        [ Background.color
            (rgb
                red
                green
                blue
            )
        , width (fillPortion 1)
        , height (px 400)
        ]
        [ Element.column [ padding extraLarge.value ]
            [ title
            ]
        ]


imageBlock : String -> Element ()
imageBlock img =
    Element.row
        [ Background.image img
        , width (fillPortion 1)
        , height (px 400)
        ]
        []


title : Element ()
title =
    Text.text typography.lead
        color.neutral.white
        ("Bienvenue au grec parisien" |> String.toUpper)


view : Html.Html ()
view =
    layout [] (Element.row [ width fill ] [ block color.brand.primary, imageBlock "http://www.ledahu.net/dahu/wp-content/uploads/A-3.jpg" ])
