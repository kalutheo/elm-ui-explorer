module Components.Text.Stories exposing (stories)

import Components.Text.View as TextView
import Element exposing (..)
import Theme.Color exposing (color)
import Theme.Typography exposing (typography)
import UIExplorer exposing (createUI)


stories : UIExplorer.UI a b { hasMenu : Bool }
stories =
    createUI
        "Text"
        [ ( "Default"
          , \_ ->
                toHtml <|
                    TextView.text
                        "Hello world"
                        typography.title
                        color.brand.secondaryVariant
          , { hasMenu = False }
          )
        ]


toHtml =
    Element.layout []
