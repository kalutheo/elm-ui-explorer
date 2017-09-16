module Organism.Hero.Stories exposing (..)

import Organism.Hero.Index exposing (view, Model)
import UIExplorer exposing (renderStories)


states : List ( String, Model )
states =
    [ ( "Default"
      , { title = "Lorem"
        , subtitle = "Ipsum"
        , linkLabel = "Dolor"
        }
      )
    ]


viewStories config =
    renderStories config view states
