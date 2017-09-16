module App exposing (..)

import UIExplorer exposing (app)
import Atom.Button.Stories as Button
import Atom.Toast.Stories as Toast
import Atom.Logo.Stories as Logo
import Atom.Global.Colors.Stories as Colors
import Atom.Typography.Stories as Typography
import Molecule.Card.Stories as Card
import Molecule.Menu.Stories as Menu
import Organism.CardGrid.Stories as CardGrid
import Organism.Header.Stories as Header
import Organism.Hero.Stories as Hero
import Page.Home.Stories as Home
import Page.Contacts.Stories as Contacts


main =
    app
        [ ( "Atoms"
          , [ { id = "Colors"
              , description = "Global Color Schemes"
              , viewStories = Colors.viewStories
              }
            , { id = "Button"
              , description = ""
              , viewStories = Button.viewStories
              }
            , { id = "Logo"
              , description = ""
              , viewStories = Logo.viewStories
              }
            , { id = "Typography"
              , description = "List of fonts with sizes"
              , viewStories = Typography.viewStories
              }
            ]
          )
        , ( "Molecules"
          , [ { id = "Card"
              , description = ""
              , viewStories = Card.viewStories
              }
            , { id = "Toast"
              , description = ""
              , viewStories = Toast.viewStories
              }
            , { id = "Menu"
              , description = "The main navigation menu"
              , viewStories = Menu.viewStories
              }
            ]
          )
        , ( "Organisms"
          , [ { id = "CardGrid"
              , description = "A grid of cards"
              , viewStories = CardGrid.viewStories
              }
            , { id = "Header"
              , description = ""
              , viewStories = Header.viewStories
              }
            , { id = "Hero"
              , description = ""
              , viewStories = Hero.viewStories
              }
            ]
          )
        , ( "Pages"
          , [ { id = "Home"
              , description = "Welcome page"
              , viewStories = Home.viewStories
              }
            , { id = "Contacts"
              , description = "Lists your contacts"
              , viewStories = Contacts.viewStories
              }
            ]
          )
        ]
