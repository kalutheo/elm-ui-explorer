module App exposing (..)

import StoryBook exposing (storybook)
import Atom.Button.Story as Button
import Atom.Toast.Story as Toast
import Atom.Logo.Story as Logo
import Atom.Global.Colors.Story as Colors
import Atom.Typography.Story as Typography
import Molecule.Card.Story as Card
import Molecule.Menu.Story as Menu
import Organism.CardGrid.Story as CardGrid
import Organism.Header.Story as Header
import Organism.Hero.Story as Hero
import Page.Home.Story as Home
import Page.Contacts.Story as Contacts


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
            , { id = "Logo"
              , description = "The logo"
              , view = Logo.story
              }
            , { id = "Typography"
              , description = "List of font with sizes"
              , view = Typography.story
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
            , { id = "Menu"
              , description = "the main navigation menu"
              , view = Menu.story
              }
            ]
          )
        , ( "Organisms"
          , [ { id = "CardGrid"
              , description = "a grid of cards"
              , view = CardGrid.story
              }
            , { id = "Header"
              , description = ""
              , view = Header.story
              }
            , { id = "Hero"
              , description = ""
              , view = Hero.story
              }
            ]
          )
        , ( "Pages"
          , [ { id = "Home"
              , description = "Welcome page"
              , view = Home.story
              }
            , { id = "Contacts"
              , description = "Lists your contacts"
              , view = Contacts.story
              }
            ]
          )
        ]
