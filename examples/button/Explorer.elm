module Explorer exposing (main)

import Button exposing (..)
import UIExplorer exposing (ExplorerProgram, app, createUI, defaultConfig, explore)


main : ExplorerProgram {} () {}
main =
    app
        (explore
            [ createUI
                "Button"
                [ ( "Primary", \_ -> Button.view "Submit" defaultButtonConfig (), {} )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary } (), {} )
                , ( "Small", \_ -> Button.view "Submit" { defaultButtonConfig | size = S } (), {} )
                , ( "Large", \_ -> Button.view "Submit" { defaultButtonConfig | size = L } (), {} )
                , ( "Link", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Link, appearance = Secondary } (), {} )
                , ( "GhostPrimary", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Ghost } (), {} )
                , ( "GhostSecondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary, kind = Ghost } (), {} )
                ]
            ]
        )
        defaultConfig
