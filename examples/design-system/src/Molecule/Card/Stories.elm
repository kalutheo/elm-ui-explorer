module Molecule.Card.Stories exposing (..)

import Molecule.Card.Index exposing (view)
import UIExplorer exposing (renderStories)
import Html exposing (div)
import Html.Attributes exposing (style)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


card model =
    div [ style [ ( "width", "400px" ) ] ] [ view model ]


viewStories config =
    renderStories config card states
