module Organism.Header.Stories exposing (..)

import Organism.Header.Index exposing (view)
import UIExplorer exposing (renderStories)
import Html exposing (div)
import Html.Attributes exposing (style)


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
