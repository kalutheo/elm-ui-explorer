module Explorer exposing (main)

import Button exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Main exposing (Msg(..))
import UIExplorer exposing (Msg(..), UIViewConfig, app, createUI, explore)


type Msg
    = MyCustomMsg


type alias ExplorerModel =
    UIExplorer.Model {}


type alias ExplorerMsg =
    UIExplorer.Msg


viewEnhancer stories =
    div [] [ Html.span [ onClick ExternalMsg ] [ Html.text "houra" ], stories ]


main : Program () ExplorerModel ExplorerMsg
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
        { customModel = {}, toMsg = MyCustomMsg, update = \m -> m, viewEnhancer = viewEnhancer }
