module Atom.Global.Colors.Story exposing (..)

import Atom.Global.Colors.Index exposing (..)
import StoryBook.View exposing (renderStory)
import Util exposing (..)
import Atom.System exposing (..)


states : List ( String, Model )
states =
    [ ( "Brand"
      , { colors =
            [ colors.primary
            , colors.secondary
            ]
        }
      )
    , ( "Neutral"
      , { colors =
            [ colors.light
            , colors.gray2
            , colors.gray15
            , colors.gray35
            , colors.gray50
            , colors.gray65
            , colors.gray73
            , colors.gray87
            , colors.black
            ]
        }
      )
    , ( "Utility"
      , { colors =
            [ colors.success
            , colors.warning
            , colors.danger
            ]
        }
      )
    ]


story selectedStateId =
    renderStory selectedStateId view states emptyMsg emptyDiv
