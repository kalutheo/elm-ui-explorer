module ExplorerWithNotes exposing (main)

import Button exposing (..)
import ExplorerNotesPlugin exposing (addNote)
import Html
import UIExplorer
    exposing
        ( ExplorerProgram
        , ViewEnhancer
        , app
        , createUI
        , defaultConfig
        , explore
        , findStory
        )


type alias PluginOption =
    { notes : ExplorerNotesPlugin.PluginModel
    }


note =
    { notes = addNote """

# Button


The Button should be used to trigger user actions.
Some examples of interactions:

- Submit a form
- Cancel an order
- Toggle a menu visibility
- Play a media


Basic usage

```elm
import Button exposing (..)
Button.view "Submit" defaultButtonConfig ()
```


Links

- [UX Planet - Basic rules for button](https://uxplanet.org/7-basic-rules-for-button-design-63dcdf5676b4)

""" }


main : ExplorerProgram {} () PluginOption
main =
    app
        (explore
            [ createUI
                "Button"
                [ ( "Primary", \_ -> Button.view "Submit" defaultButtonConfig (), note )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary } (), note )
                , ( "Small", \_ -> Button.view "Submit" { defaultButtonConfig | size = S } (), note )
                , ( "Large", \_ -> Button.view "Submit" { defaultButtonConfig | size = L } (), note )
                , ( "Link", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Link, appearance = Secondary } (), note )
                , ( "GhostPrimary", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Ghost } (), note )
                , ( "GhostSecondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary, kind = Ghost } (), note )
                ]
            ]
        )
        { defaultConfig | viewEnhancer = ExplorerNotesPlugin.viewEnhancer }
