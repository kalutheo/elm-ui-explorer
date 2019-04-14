module Explorer exposing (main)

import Button exposing (Appearance(..), Kind(..), Size(..), defaultButtonConfig)
import UIExplorer exposing (UIExplorerProgram, defaultConfig, explore, storiesOf)


main : UIExplorerProgram {} () {}
main =
    explore
        defaultConfig
        [ storiesOf
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
