module Page.Contacts.Stories exposing (..)

import Page.Contacts.Index exposing (view)
import UIExplorer exposing (renderStories)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


viewStories config =
    renderStories config view states
