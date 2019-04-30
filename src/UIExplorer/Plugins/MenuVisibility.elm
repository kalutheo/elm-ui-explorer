module UIExplorer.Plugins.MenuVisibility exposing (menuViewEnhancer)

{-|


# Menu Visibility Plugin

This plugin allows to hide or show the menu for each story.

@docs menuViewEnhancer

-}

import Html
import UIExplorer exposing (getCurrentSelectedStory)


type alias PluginModel a =
    { a | hasMenu : Bool }


{-| This function will hide or show the menu according to what was defined for the story
-}
menuViewEnhancer : UIExplorer.Model a b (PluginModel c) -> Html.Html msg -> Html.Html msg
menuViewEnhancer model menuView =
    getCurrentSelectedStory model
        |> Maybe.map
            (\( _, _, option ) ->
                if option.hasMenu then
                    menuView

                else
                    Html.text ""
            )
        |> Maybe.withDefault (Html.text "")
