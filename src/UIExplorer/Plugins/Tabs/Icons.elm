module UIExplorer.Plugins.Tabs.Icons exposing (code, note, review)

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


review : Html.Html msg
review =
    FeatherIcons.book
        |> renderIcon


code : Html.Html msg
code =
    FeatherIcons.code
        |> renderIcon
