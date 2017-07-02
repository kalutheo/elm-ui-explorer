module App exposing (..)

import StoryBook.Index exposing (storybook)
import Atom.Button.Story as Button
import Atom.Toast.Story as Toast


main =
    storybook
        [ { id = "CustomButton"
          , description = "a simple button"
          , view = Button.story
          }
        , { id = "Toast"
          , description = "a simple Toast"
          , view = Toast.story
          }
        ]
