module Explorer exposing (main)

import Button exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Main exposing (Msg(..), view)
import UIExplorer exposing (app, createUI, explore)


main : Program () UIExplorer.Model UIExplorer.Msg
main =
    app
        (explore
            [ createUI
                "Button"
                [ ( "Primary", \_ -> Button.view "Submit" defaultConfig NoOp )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultConfig | appearance = Secondary } NoOp )
                , ( "Small", \_ -> Button.view "Submit" { defaultConfig | size = S } NoOp )
                , ( "Large", \_ -> Button.view "Submit" { defaultConfig | size = L } NoOp )
                , ( "Link", \_ -> Button.view "Submit" { defaultConfig | kind = Link, appearance = Secondary } NoOp )
                , ( "GhostPrimary", \_ -> Button.view "Submit" { defaultConfig | kind = Ghost } NoOp )
                , ( "GhostSecondary", \_ -> Button.view "Submit" { defaultConfig | appearance = Secondary, kind = Ghost } NoOp )
                ]
            ]
        )
