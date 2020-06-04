module UIExplorer.Plugins.Tabs.Icons exposing
    ( note
    , code
    , menu
    )

{-|


# Tabs

This plugin allows to display icons for the Tabs Plugin.

@docs note

@docs code

-}

import FeatherIcons
import Html


renderIcon : FeatherIcons.Icon -> Html.Html msg
renderIcon icon =
    icon
        |> FeatherIcons.withSize 14
        |> FeatherIcons.toHtml []


{-| Icon for notes
-}
note : Html.Html msg
note =
    FeatherIcons.eye
        |> renderIcon


{-| Icon for menu
-}
menu : Html.Html msg
menu =
    FeatherIcons.menu
        |> renderIcon


{-| Icon for code
-}
code : Html.Html msg
code =
    FeatherIcons.code
        |> renderIcon
