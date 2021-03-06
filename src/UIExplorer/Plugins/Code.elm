module UIExplorer.Plugins.Code exposing (viewEnhancer)

{-|


# Tabs

This plugin allows to display code in your stories.
This can be usefull for documenting your stories

See usage [here](https://github.com/kalutheo/elm-ui-explorer/blob/master/examples/button/ExplorerWithNotes.elm)

@docs viewEnhancer

-}

import Html
import Html.Attributes exposing (class, style)
import Markdown
import UIExplorer exposing (getCurrentSelectedStory)
import UIExplorer.ColorMode exposing (ColorMode(..))


{-| Code view enhancer
-}
viewEnhancer : UIExplorer.Model a b { c | code : String } -> Html.Html (UIExplorer.Msg b)
viewEnhancer model =
    let
        colorModeClassList =
            case model.colorMode of
                Just Dark ->
                    [ class "uie-text-white" ]

                _ ->
                    []
    in
    case getCurrentSelectedStory model of
        Just ( _, _, option ) ->
            Markdown.toHtml (colorModeClassList ++ [ class "content uie-text-sm  uie-overflow-auto", style "width" "100%" ]) option.code

        Nothing ->
            Html.text ""
