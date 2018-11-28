module ExplorerWithNotes exposing (main)

import Button exposing (..)
import Html
import UIExplorer exposing (ExplorerProgram, app, createUI, defaultConfig, explore)


type alias PluginOption =
    { note : String
    }


viewEnhancer model storiesView =
    let
        _ =
            Debug.log "model" (List.head model.categories)
    in
    Html.div [] [ storiesView, Html.br [] [], Html.text "-------" ]


main : ExplorerProgram {} () PluginOption
main =
    app
        (explore
            [ createUI
                "Button"
                [ ( "Primary", \_ -> Button.view "Submit" defaultButtonConfig (), { note = "A" } )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary } (), { note = "B" } )
                , ( "Small", \_ -> Button.view "Submit" { defaultButtonConfig | size = S } (), { note = "C" } )
                , ( "Large", \_ -> Button.view "Submit" { defaultButtonConfig | size = L } (), { note = "D" } )
                , ( "Link", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Link, appearance = Secondary } (), { note = "E" } )
                , ( "GhostPrimary", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Ghost } (), { note = "F" } )
                , ( "GhostSecondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary, kind = Ghost } (), { note = "G" } )
                ]
            ]
        )
        { defaultConfig | viewEnhancer = viewEnhancer }
