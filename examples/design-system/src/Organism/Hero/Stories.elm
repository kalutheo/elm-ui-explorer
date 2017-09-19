module Organism.Hero.Stories exposing (..)

import Organism.Hero.Index exposing (view, Model)
import UIExplorer exposing (renderStories)


stories : List ( String, Model )
stories =
    [ ( "Default"
      , { title = "Lorem"
        , subtitle = "Ipsum"
        , linkLabel = "Dolor"
        }
      )
    ]


viewStories config =
    renderStories config view stories
