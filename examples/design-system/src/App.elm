module App exposing (..)

import UIExplorer exposing (app, addUICategory, emptyUICategories, createUI, createUIWithDescription)
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
        (emptyUICategories
            |> addUICategory
                "Atoms"
                [ createUIWithDescription
                    "Colors"
                    "Global Color Schemes"
                    Colors.viewStories
                , createUI
                    "Button"
                    Button.viewStories
                , createUI
                    "Logo"
                    Logo.viewStories
                , createUIWithDescription
                    "Typography"
                    "List of fonts with sizes"
                    Typography.viewStories
                ]
            |> addUICategory
                "Molecules"
                [ createUI
                    "Card"
                    Card.viewStories
                , createUI
                    "Toast"
                    Toast.viewStories
                , createUI
                    "Menu"
                    Menu.viewStories
                ]
            |> addUICategory
                "Organisms"
                [ createUI
                    "CardGrid"
                    CardGrid.viewStories
                , createUI
                    "Header"
                    Header.viewStories
                , createUI
                    "Hero"
                    Hero.viewStories
                ]
            |> addUICategory
                "Pages"
                [ createUIWithDescription
                    "Home"
                    "Welcome page"
                    Home.viewStories
                , createUIWithDescription
                    "Contacts"
                    "Lists your contacts"
                    Contacts.viewStories
                ]
        )
