module Explorer exposing (main)

import Button exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Main exposing (Msg, view)
import UIExplorer exposing (app, createUI, explore)


main : Program () UIExplorer.Model UIExplorer.Msg
main =
    app
        (explore
            [ createUI
                "Button"
                [ ( "Default", \_ -> Button.view "Submit" defaultConfig )
                , ( "Small", \_ -> Button.view "Submit" { defaultConfig | size = S } )
                , ( "Large", \_ -> Button.view "Submit" { defaultConfig | size = L } )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultConfig | appearance = Secondary } )
                , ( "Link", \_ -> Button.view "Submit" { defaultConfig | kind = Link, appearance = Secondary } )
                ]
            ]
        )
