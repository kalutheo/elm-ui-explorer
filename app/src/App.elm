module App exposing (..)

import StoryBook.View exposing (storybook)
import Atom.Button as Button
import Atom.Toast as Toast
import Atom.Collapsible as Collapsible


main =
    storybook
        { stories =
            [ { id = "Collapsible"
              , description = "a simple collapsible"
              , view = Collapsible.story
              }
            , { id = "CustomButton"
              , description = "a simple button"
              , view = Button.story
              }
            , { id = "Toast"
              , description = "a simple toast"
              , view = Toast.story
              }
            ]
        , selectedStoryId = Nothing
        , selectedStateId = Nothing
        }
