module Page.Home.Stories exposing (..)

import Page.Home.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


viewStories =
    renderStories view stories


viewSnapshot =
    UIExplorer.viewSnapshot stories view
