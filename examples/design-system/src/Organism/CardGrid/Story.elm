module Organism.CardGrid.Story exposing (..)

import Organism.CardGrid.Index exposing (view)
import UIExplorer exposing (renderStory)
import Html exposing (div)
import Html.Attributes exposing (style)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


grid model =
    div [ style [ ( "width", "80%" ) ] ] [ view model ]


story config =
    renderStory config grid states
