module App exposing (..)

import StoryBook.Index exposing (storybook)
import Atom.Button.Story as Button
import Atom.Toast.Story as Toast
import Atom.Collapsible.Story as Collapsible


main =
    storybook
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
