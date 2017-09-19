module Page.Home.Stories exposing (..)

import Page.Home.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


viewStories config =
    renderStories config view stories
