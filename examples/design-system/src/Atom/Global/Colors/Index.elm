module Atom.Global.Colors.Index exposing (..)

import Html exposing (Html, text, div)
import Elegant exposing (..)
import Color exposing (..)


type alias Model =
    { colors : List Color }


colorBox : Color -> Html msg
colorBox color =
    div
        [ style
            [ backgroundColor color
            , width (Px 80)
            , height (Px 80)
            , margin (Px 10)
            , marginLeft (Em 0)
            ]
        ]
        []


view : Model -> Html msg
view m =
    div [ style [ displayFlex ] ]
        (List.map
            (\c -> colorBox c)
            m.colors
        )
