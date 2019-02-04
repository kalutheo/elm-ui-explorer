module Components.Button.Stories exposing (stories)

import Color as RawColor
import Color.Convert exposing (colorToHex)
import Components.Button.View as Button exposing (..)
import Css exposing (hex, rgb)
import Element exposing (..)
import Element.Background as Background
import Html
import Theme.Color exposing (color, getColor)
import UIExplorer exposing (createUI)
import Utils exposing (toRgb)


makeColor : Theme.Color.Color -> Css.Color
makeColor =
    getColor >> colorToHex >> Css.hex


config : Config
config =
    { defaultButtonConfig
        | theme =
            { primary = makeColor color.brand.primary
            , secondary = makeColor color.brand.alternative
            }
    }


stories : UIExplorer.UI a () { hasMenu : Bool }
stories =
    createUI
        "Button"
        [ ( "Primary", \_ -> Button.view "Submit" config (), { hasMenu = True } )
        , ( "Secondary", \_ -> Button.view "Submit" { config | appearance = Secondary } (), { hasMenu = True } )
        , ( "Small", \_ -> Button.view "Submit" { config | size = S } (), { hasMenu = True } )
        , ( "Large", \_ -> Button.view "Submit" { config | size = L } (), { hasMenu = True } )
        , ( "Link", \_ -> Button.view "Submit" { config | kind = Link, appearance = Secondary } (), { hasMenu = True } )
        , ( "GhostPrimary", \_ -> Button.view "Submit" { config | kind = Ghost } (), { hasMenu = True } )
        , ( "GhostSecondary", \_ -> Button.view "Submit" { config | appearance = Secondary, kind = Ghost } (), { hasMenu = True } )
        ]
