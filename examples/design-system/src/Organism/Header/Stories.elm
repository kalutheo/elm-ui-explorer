module Organism.Header.Stories exposing (..)

import Html exposing (div)
import Html.Attributes exposing (style)
import Organism.Header.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


nav model =
    div [ style [ ( "width", "80%" ) ] ] [ view model ]


viewStories =
    renderStories nav stories


viewSnapshot =
    UIExplorer.viewSnapshot stories view
