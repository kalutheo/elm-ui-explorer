module UIExplorer.Plugins.MenuVisibility exposing (menuViewEnhancer)

{-|


# Menu Visibility Plugin

This plugin allows to hide or show the menu for each story.

Example:

    import UIExplorer.Plugins.MenuVisibility as MenuVisibility

    main : UIExplorerProgram {} () { a | note : String }
    main =
        explore
            { defaultConfig | viewEnhancer = MenuVisibility.viewEnhancer }
            [ storiesOf
              "About"
              [ ( "HideMenu", _ -> myView { hasMenu = False } ),
              ( "ShowMenu", _ -> myView { hasMenu = True } )
              ]
            ]

@docs menuViewEnhancer

-}

import Html
import UIExplorer exposing (getCurrentSelectedStory)


{-| This function will hide or show the menu according to what was defined for the story
-}
menuViewEnhancer : UIExplorer.Model a b { c | hasMenu : Bool } -> Html.Html msg -> Html.Html msg
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
