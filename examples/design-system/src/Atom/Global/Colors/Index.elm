module Atom.Global.Colors.Index exposing (..)

import Html exposing (Html, text, div)
import Html.Attributes exposing (style)


type alias Model =
    { colors : List String }


colorBox : String -> Html msg
colorBox color =
    div
        [ style
            [ ( "backgroundColor", color )
            , ( "width", "80px" )
            , ( "height", "80px" )
            , ( "margin", "10px" )
            , ( "marginLeft", "0px" )
            ]
        ]
        []


view : Model -> Html msg
view m =
    div [ style [ ( "display", "flex" ) ] ]
        (List.map
            (\c -> colorBox c)
            m.colors
        )
