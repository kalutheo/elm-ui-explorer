module Explorer exposing (main)

import Html exposing (Html, hr)
import Html.Attributes as Attr
import Html.Events as Events
import HtmlComponent
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
                    , TabsPlugin.view m.customModel.tabs
                        [ ( "Notes", NotePlugin.viewEnhancer m, TabsIconsPlugin.note )
                        , ( "Story Code", CodePlugin.viewEnhancer m, TabsIconsPlugin.code )
                        ]
                        TabMsg
                    ]
        , menuViewEnhancer = \m v -> v
        }
        [ storiesOf
            "Button"
            [ ( "Primary", \_ -> HtmlComponent.view RawContent.sourceCode, options )
            ]
        ]
