module ExplorerWithNotes exposing (main)

import Button exposing (..)
import Html exposing (Html, hr)
import Html.Attributes as Attr
import Html.Events as Events
import NoUnused.Variables
import RawContent
import UIExplorer
    exposing
        ( UIExplorerProgram
        , ViewEnhancer
        , defaultConfig
        , explore
        , storiesOf
        )
import UIExplorer.Plugins.Note as NotePlugin
import UIExplorer.Plugins.Review as ReviewPlugin
import UIExplorer.Plugins.Tabs as TabsPlugin


type alias PluginOption =
    { note : String
    , review : ReviewPlugin.PluginOption
    }


options =
    { note = RawContent.note
    , review =
        { errors = ReviewPlugin.initErrors [ NoUnused.Variables.rule ] RawContent.sourceCode
        , sourceCode = RawContent.sourceCode
        }
    }


type Msg
    = TabMsg TabsPlugin.Msg
    | NoOp


type alias Model =
    { tabs : { displayedTab : Int } }


main : UIExplorerProgram Model Msg PluginOption
main =
    explore
        { customModel = { tabs = { displayedTab = 0 } }
        , customHeader = Nothing
        , update =
            \msg m ->
                case msg of
                    TabMsg submsg ->
                        let
                            tabs =
                                m.customModel.tabs

                            customModel =
                                m.customModel

                            newTab =
                                TabsPlugin.update submsg tabs

                            newCustomModel =
                                { customModel | tabs = newTab }
                        in
                        { m | customModel = newCustomModel }

                    _ ->
                        m
        , viewEnhancer =
            \m stories ->
                Html.div []
                    [ stories
                    , TabsPlugin.view m.customModel.tabs
                        [ ( "Notes", NotePlugin.viewEnhancer m )
                        , ( "Review", ReviewPlugin.viewEnhancer m )
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
