module Atom.Global.Colors.Story exposing (..)

import Atom.Global.Colors.Index exposing (..)
import StoryBook exposing (renderStory)
import Atom.System exposing (..)


states : List ( String, Model )
states =
    [ ( "Brand"
      , { colors =
            [ "#db7093"
            , "#ff6347"
            ]
        }
      )
    , ( "Neutral"
      , { colors =
            [ "hsl(0, 0%, 4%)"
            , "hsl(0, 0%, 21%)"
            , "hsl(0, 0%, 96%)"
            ]
        }
      )
    , ( "Utility"
      , { colors =
            [ "hsl(141, 71%, 48%)"
            , "hsl(48, 100%, 67%)"
            , "hsl(348, 100%, 61%)"
            ]
        }
      )
    ]


story config =
    renderStory config view states
