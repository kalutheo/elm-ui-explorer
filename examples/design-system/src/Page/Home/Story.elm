module Page.Home.Story exposing (..)

import Page.Home.Index exposing (view)
import StoryBook exposing (renderStory)
import Html exposing (div)
import Html.Attributes exposing (style)


states : List ( String, {} )
states =
    [ ( "Default"
      , {}
      )
    ]


story config =
    renderStory config view states
