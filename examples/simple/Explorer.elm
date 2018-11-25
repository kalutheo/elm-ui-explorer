module Explorer exposing (main)

import Button exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Main exposing (Msg, view)
import UIExplorer exposing (app, createUI, explore)


type MockMsg
    = MockMsg


main : Program () UIExplorer.Model UIExplorer.Msg
main =
    app
        (explore
            [ createUI
                "Button"
                [ ( "Default", \_ -> Button.view "Submit" defaultConfig MockMsg )
                , ( "Small", \_ -> Button.view "Submit" { defaultConfig | size = S } MockMsg )
                , ( "Large", \_ -> Button.view "Submit" { defaultConfig | size = L } MockMsg )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultConfig | appearance = Secondary } MockMsg )
                , ( "Link", \_ -> Button.view "Submit" { defaultConfig | kind = Link, appearance = Secondary } MockMsg )
                ]
            ]
        )
