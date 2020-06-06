port module ExplorerWithNotes exposing (main)

import Button exposing (..)
import Html exposing (Html, hr)
import Html.Attributes as Attr
import Html.Events as Events
import RawContent
import UIExplorer
    exposing
        ( UIExplorerProgram
        , ViewEnhancer
        , defaultConfig
        , explore
        , storiesOf
        )
import UIExplorer.Plugins.Code as CodePlugin
import UIExplorer.Plugins.Note as NotePlugin
import UIExplorer.Plugins.Tabs as TabsPlugin
import UIExplorer.Plugins.Tabs.Icons as TabsIconsPlugin
import UIExplorer.ColorMode exposing (colorModeToString)

port onModeChanged : String -> Cmd msg

type alias PluginOption =
    { note : String
    , code : String
    }


type Msg
    = TabMsg TabsPlugin.Msg
    | NoOp


type alias Model =
    { tabs : TabsPlugin.Model }


options =
    { note = RawContent.note
    , code = RawContent.storySourceCode
    }


main : UIExplorerProgram Model Msg PluginOption
main =
    explore
        { customModel = { tabs = TabsPlugin.initialModel }
        , customHeader = Nothing
        , subscriptions = \_ -> Sub.none
        , onModeChanged = Just (onModeChanged << colorModeToString )
        , update =
            \msg m ->
                case msg of
                    TabMsg submsg ->
                        let
                            cm =
                                m.customModel
                        in
                        ( { m | customModel = { cm | tabs = TabsPlugin.update submsg m.customModel.tabs } }, Cmd.none )

                    _ ->
                        ( m, Cmd.none )
        , viewEnhancer =
            \m stories ->
                Html.div []
                    [ stories
                    , TabsPlugin.view m.colorMode m.customModel.tabs
                        [ ( "Notes", NotePlugin.viewEnhancer m, TabsIconsPlugin.note )
                        , ( "Story Code", CodePlugin.viewEnhancer  m, TabsIconsPlugin.code )
                        ]
                        TabMsg
                    ]
        , menuViewEnhancer = \m v -> v
        }
        [ storiesOf
            "Button"
            [ ( "Primary", \_ -> Button.view "Submit" defaultButtonConfig NoOp, options )
            , ( "Secondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary } NoOp, options )
            , ( "Small", \_ -> Button.view "Submit" { defaultButtonConfig | size = S } NoOp, options )
            , ( "Large", \_ -> Button.view "Submit" { defaultButtonConfig | size = L } NoOp, options )
            , ( "Link", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Link, appearance = Secondary } NoOp, options )
            , ( "Ghost Primary", \_ -> Button.view "Submit" { defaultButtonConfig | kind = Ghost } NoOp, options )
            , ( "GhostSecondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary, kind = Ghost } NoOp, options )
            ]
        ]
