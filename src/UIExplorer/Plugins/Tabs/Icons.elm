module UIExplorer.Plugins.Tabs.Icons exposing (code, note)

import FeatherIcons
import Html


renderIcon : FeatherIcons.Icon -> Html.Html msg
renderIcon icon =
    icon
        |> FeatherIcons.withSize 14
        |> FeatherIcons.toHtml []


note : Html.Html msg
note =
    FeatherIcons.eye
        |> renderIcon



code : Html.Html msg
code =
    FeatherIcons.code
        |> renderIcon
