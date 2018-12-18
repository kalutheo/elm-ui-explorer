module Components.Text.Stories exposing (stories)

import Color
import Components.Text.View as TextView
import Element exposing (..)
import Theme.Typography exposing (typography)
import UIExplorer exposing (createUI)


stories : UIExplorer.UI a b { hasMenu : Bool }
stories =
    createUI
        "Text"
        [ ( "Default"
          , \_ ->
                Element.layout [] <|
                    TextView.text "Hello world"
                        typography.lead
                        { color = Color.rgb 0 0 0, name = "nothing to say" }
          , { hasMenu = False }
          )
        ]
