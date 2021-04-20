module ExplorerWithFlags exposing (main)

import Button exposing (Appearance(..), Kind(..), Size(..), defaultButtonConfig)
import UIExplorer exposing (UIExplorerProgram, defaultConfig, explore, storiesOf)

type alias Model = { buttonLabel: String}

initialModel : Model 
initialModel = { buttonLabel = ""}


main : UIExplorerProgram Model () {} String
main =
    explore
        { customModel = initialModel
        , customHeader = Nothing
        , update = \_ m -> ( m, Cmd.none )
        , init = \f m -> {m| buttonLabel = f }
        , enableDarkMode = True
        , subscriptions = \_ -> Sub.none
        , viewEnhancer = \_ stories -> stories
        , menuViewEnhancer = \_ v -> v
        , onModeChanged = Nothing
        , documentTitle = Just "This is an example with flags"
        }

        [ storiesOf
            "Button"
            [ ( "Primary", \{customModel} -> Button.view customModel.buttonLabel defaultButtonConfig (), {} )
            , ( "Secondary", \{customModel} -> Button.view customModel.buttonLabel { defaultButtonConfig | appearance = Secondary } (), {})
            , ( "Small", \{customModel} -> Button.view  customModel.buttonLabel { defaultButtonConfig | size = S } (), {} )
            , ( "Large", \{customModel} -> Button.view  customModel.buttonLabel { defaultButtonConfig | size = L } (), {} )
            , ( "Link", \{customModel} -> Button.view  customModel.buttonLabel { defaultButtonConfig | kind = Link, appearance = Secondary } (), {} )
            , ( "GhostPrimary", \{customModel} -> Button.view  customModel.buttonLabel { defaultButtonConfig | kind = Ghost } (), {} )
            , ( "GhostSecondary", \{customModel} -> Button.view  customModel.buttonLabel { defaultButtonConfig | appearance = Secondary, kind = Ghost } (), {} )
            ]
        ]
