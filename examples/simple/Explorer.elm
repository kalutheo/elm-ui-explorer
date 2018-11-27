module Explorer exposing (main)

import Button exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Main exposing (Msg(..))
import UIExplorer exposing (Msg(..), UIViewConfig, app, createUI, explore)


type Msg
    = ChangeOpacity


type alias ExplorerModel =
    UIExplorer.Model {} Msg


type alias ExplorerMsg =
    UIExplorer.Msg Msg


viewEnhancer stories =
    div []
        [ stories
        , div [] [ Html.span [ onClick (ExternalMsg ChangeOpacity) ] [ Html.text "houra" ] ]
        ]


main : Program () ExplorerModel ExplorerMsg
main =
    app
        (explore
            [ createUI
                "Button"
                [ ( "Primary", \_ -> Button.view "Submit" defaultConfig () )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultConfig | appearance = Secondary } () )
                , ( "Small", \_ -> Button.view "Submit" { defaultConfig | size = S } () )
                , ( "Large", \_ -> Button.view "Submit" { defaultConfig | size = L } () )
                , ( "Link", \_ -> Button.view "Submit" { defaultConfig | kind = Link, appearance = Secondary } () )
                , ( "GhostPrimary", \_ -> Button.view "Submit" { defaultConfig | kind = Ghost } () )
                , ( "GhostSecondary", \_ -> Button.view "Submit" { defaultConfig | appearance = Secondary, kind = Ghost } () )
                ]
            ]
        )
        { customModel = {}
        , update =
            \msg m -> m
        , viewEnhancer = viewEnhancer
        }
