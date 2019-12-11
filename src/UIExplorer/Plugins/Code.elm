module UIExplorer.Plugins.Code exposing (viewEnhancer)

import Html
import Html.Attributes exposing (class, style)
import Markdown
import UIExplorer exposing (ViewEnhancer, explore, getCurrentSelectedStory)


viewEnhancer : UIExplorer.Model a b { c | code : String } -> Html.Html (UIExplorer.Msg b)
viewEnhancer model =
    case getCurrentSelectedStory model of
        Just ( _, _, option ) ->
            Markdown.toHtml [ class "content uie-text-sm", style "width" "100%" ] option.code

        Nothing ->
            Html.text ""
