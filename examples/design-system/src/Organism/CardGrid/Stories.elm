module Organism.CardGrid.Stories exposing (..)

import Organism.CardGrid.Index exposing (view)
import UIExplorer exposing (renderStories)
import Html exposing (div)
import Html.Attributes exposing (style)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


grid model =
    div [ style [ ( "width", "80%" ) ] ] [ view model ]


viewStories config =
    renderStories config grid stories
