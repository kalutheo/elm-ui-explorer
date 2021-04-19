module ExplorerWithKnobs exposing (main)

import Button exposing (..)
import Debug.Control exposing (choice, field, record, string, value)
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
import UIExplorer.Plugins.Knobs as KnobsPlugin
import UIExplorer.Plugins.Tabs as TabsPlugin
import UIExplorer.Plugins.Tabs.Icons as TabsIconsPlugin
import UIExplorer.ColorMode exposing (ColorMode(..))

type alias ButtonModel =
    { label : String
    , appearance : Button.Appearance
    }


type alias PluginOption =
    { knobs : Bool
    }


type Msg
    = TabMsg TabsPlugin.Msg
    | ButtonKnobsChanged (Debug.Control.Control ButtonModel)
    | NoOp


type alias Model =
    { tabs : TabsPlugin.Model, button : Debug.Control.Control ButtonModel }


options =
    { knobs = True
    }


main : UIExplorerProgram Model Msg PluginOption ()
main =
    explore
        { customModel =
            { tabs = TabsPlugin.initialModel
            , button =
                record ButtonModel
                    |> field "label" (string "Click here")
                    |> field "appearance"
                        (choice
                            [ ( "Primary", value Button.Primary )
                            , ( "Secondary", value Button.Secondary )
                            ]
                        )
            }
        , customHeader = Nothing
        , subscriptions = \_ -> Sub.none
        , update =
            \msg m ->
                let
                    cm =
                        m.customModel
                in
                case msg of
                    TabMsg submsg ->
                        ( { m | customModel = { cm | tabs = TabsPlugin.update submsg m.customModel.tabs } }, Cmd.none )

                    ButtonKnobsChanged button ->
                        KnobsPlugin.updateKnobs m cm (\c -> { c | button = button })

                    _ ->
                        ( m, Cmd.none )
        , viewEnhancer =
            \m stories ->
                let
                  colorMode = m.colorMode |> Maybe.withDefault Light 
                in
                Html.div []
                    [ stories
                    , TabsPlugin.view colorMode m.customModel.tabs
                        [ ( "Knobs"
                          , KnobsPlugin.viewEnhancer m
                                (\model option ->
                                    KnobsPlugin.viewKnobsForUI model ButtonKnobsChanged .button
                                )
                          , TabsIconsPlugin.note
                          )
                        ]
                        TabMsg
                    ]
        , menuViewEnhancer = \m v -> v
        , onModeChanged = Nothing
        , documentTitle = Just "This is an example with knobs"
        , enableDarkMode = False
        , init = \_ m -> m
        }
        [ storiesOf
            "Button"
            [ ( "WithKnobs"
              , \m ->
                    let
                        button =
                            Debug.Control.currentValue m.customModel.button
                    in
                    Button.view button.label { defaultButtonConfig | appearance = button.appearance } NoOp
              , options
              )
            ]
        ]
