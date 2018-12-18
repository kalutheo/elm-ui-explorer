module Components.Text.Stories exposing (stories)

import Color
import Components.Text.View as TextView
import Element exposing (..)
import UIExplorer exposing (createUI)


stories : UIExplorer.UI a b { hasMenu : Bool }
stories =
    createUI
        "Text"
        [ ( "Default"
          , \_ ->
                Element.layout [] <|
                    TextView.text "Hello world"
                        { size = 48
                        , family = "didididi"
                        , name = "Lead"
                        , desc = "Hero or blog post title"
                        }
                        { color = Color.rgb 0 0 0, name = "nothing to say" }
          , { hasMenu = False }
          )
        ]
