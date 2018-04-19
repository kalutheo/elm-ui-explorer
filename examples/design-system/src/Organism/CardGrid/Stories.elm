module Organism.CardGrid.Stories exposing (..)

import Html exposing (div)
import Html.Attributes exposing (style)
import Organism.CardGrid.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


grid model =
    div [ style [ ( "width", "80%" ) ] ] [ view model ]


viewStories =
    renderStories grid stories


viewSnapshot =
    UIExplorer.viewSnapshot stories view
