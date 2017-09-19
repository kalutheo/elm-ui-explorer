module Page.Contacts.Stories exposing (..)

import Page.Contacts.Index exposing (view)
import UIExplorer exposing (renderStories)


stories : List ( String, {} )
stories =
    [ ( "Default"
      , {}
      )
    ]


viewStories config =
    renderStories config view stories
