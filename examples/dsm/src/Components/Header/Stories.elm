module Components.Header.Stories exposing (stories)

import Color as RawColor
import Components.Header.View as Header
import Components.Text.View as TextView
import Element exposing (..)
import Element.Background as Background
import Html
import Theme.Color exposing (color, getColor)
import UIExplorer exposing (createUI)
import Utils exposing (toRgb)


stories : UIExplorer.UI a b { hasMenu : Bool }
stories =
    createUI
        "Header"
        [ ( "Primary"
          , \_ ->
                Header.viewPrimary |> toHtml
          , { hasMenu = True }
          )
        , ( "Secondary"
          , \_ ->
                Header.viewSecondary |> toHtml
          , { hasMenu = True }
          )
        ]


toHtml : Element msg -> Html.Html msg
toHtml =
    Element.layout
        [ Background.color (toRgb color.neutral.greyLightest)
        , width fill
        , height (px 400)
        , padding 20
        ]
