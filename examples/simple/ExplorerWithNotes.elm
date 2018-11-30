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
    { notes = addNote "A" }


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
