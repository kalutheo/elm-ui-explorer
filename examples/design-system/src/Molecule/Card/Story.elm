module Molecule.Card.Story exposing (..)

import Molecule.Card.Index exposing (view)
import StoryBook exposing (renderStory)
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


story config =
    renderStory config card states
