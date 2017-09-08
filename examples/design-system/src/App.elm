module App exposing (..)

import StoryBook exposing (storybook)
import Atom.Button.Story as Button
import Atom.Toast.Story as Toast
import Atom.Global.Colors.Story as Colors
import Molecule.Card.Story as Card


main =
    storybook
        [ ( "Atoms"
          , [ { id = "Colors"
              , description = "Global Color Schemes"
              , view = Colors.story
              }
            , { id = "Button"
              , description = "a simple button"
              , view = Button.story
              }
            ]
          )
        , ( "Molecules"
          , [ { id = "Card"
              , description = "a simple card"
              , view = Card.story
              }
            , { id = "Toast"
              , description = "a simple Toast"
              , view = Toast.story
              }
            ]
          )
        , ( "Organisms", [] )
        , ( "Templates", [] )
        , ( "Pages", [] )
        ]
