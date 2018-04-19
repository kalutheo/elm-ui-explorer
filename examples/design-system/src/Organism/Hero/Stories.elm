module Organism.Hero.Stories exposing (..)

import Organism.Hero.Index exposing (Model, view)
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


viewSnapshot =
    UIExplorer.viewSnapshot stories view


viewStories =
    renderStories view stories
