module HtmlComponent exposing (view)

import Html
import Html.Parser
import Html.Parser.Util


view : String -> Html.Html msg
view t =
    Html.div []
        (case Html.Parser.run t of
            Ok nodes ->
                Html.Parser.Util.toVirtualDom nodes

            Err _ ->
                []
        )
