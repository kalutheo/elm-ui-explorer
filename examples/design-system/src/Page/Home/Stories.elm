module Page.Home.Stories exposing (..)

import Page.Home.Index exposing (view)
import UIExplorer exposing (renderStories)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


viewStories config =
    renderStories config view states
