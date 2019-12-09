module ExplorerWithNotes exposing (main)

import Button exposing (..)
import Html exposing (Html, hr)
import Html.Attributes as Attr
import NoUnused.Variables
import RawContent
import UIExplorer
    exposing
        ( UIExplorerProgram
        , defaultConfig
        , explore
        , storiesOf
        )
import UIExplorer.Plugins.Note as Note


type alias PluginOption =
    { note : String
    }


options =
    { note = RawContent.note
    , review =
        { errors = ReviewPlugin.initErrors [ NoUnused.Variables.rule ] RawContent.sourceCode
        , sourceCode = RawContent.sourceCode
        }
    }


main : UIExplorerProgram {} () PluginOption
main =
    explore
        { defaultConfig | viewEnhancer = Note.viewEnhancer }
        [ storiesOf
            "Button"
            [ ( "Primary", \_ -> Button.view "Submit" defaultButtonConfig (), options )
            , ( "Secondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary } (), options )
            , ( "Small", \_ -> Button.view "Submit" { defaultButtonConfig | size = S } (), options )
            , ( "Large", \_ -> Button.view "Submit" { defaultButtonConfig | size = L } (), options )
            , ( "Link", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Link, appearance = Secondary } (), options )
            , ( "Ghost Primary", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Ghost } (), options )
            , ( "GhostSecondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary, kind = Ghost } (), options )
            ]
        ]
