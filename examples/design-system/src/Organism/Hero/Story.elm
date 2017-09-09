module Organism.Hero.Story exposing (..)

import Organism.Hero.Index exposing (view, Model)
import StoryBook exposing (renderStory)
import Html exposing (div)
import Html.Attributes exposing (style)


states : List ( String, Model )
states =
    [ ( "Default"
      , { title = "Lorem"
        , subtitle = "Ipsum"
        , linkLabel = "Dolor"
        }
      )
    ]


story config =
    renderStory config view states
