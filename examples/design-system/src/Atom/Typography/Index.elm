module Atom.Typography.Index exposing (..)

import Html exposing (div, text, h1, h2, h3, h4, h5, h6)
import Html.Attributes exposing (class)


type alias Model =
    { label : String
    }


view model =
    div
        []
        [ h1
            [ class "title is-1" ]
            [ text model.label ]
        , h2
            [ class "title is-2" ]
            [ text model.label ]
        , h3
            [ class "title is-3" ]
            [ text model.label ]
        , h4
            [ class "title is-4" ]
            [ text model.label ]
        , h5
            [ class "title is-5" ]
            [ text model.label ]
        , h6
            [ class "title is-6" ]
            [ text model.label ]
        ]
