module UIExplorer.Plugins.Note exposing (viewEnhancer)

{-|


# Note Plugin

This plugin enables contextual notes for each story.
It can be used to display some nice markdown content to document your UI.

Example:

    note =
        { note = """
          ## Hello world
          Some markdown content here...
         """
        }

    main : UIExplorerProgram {} () { a | note : String }
    main =
        explore
            { defaultConfig | viewEnhancer = ExplorerNotesPlugin.viewEnhancer }
            [ storiesOf
                "Button"
                [ ( "Primary", \_ -> Button.view "Submit" defaultButtonConfig (), note )
                , ( "Secondary", \_ -> Button.view "Submit" { defaultButtonConfig | appearance = Secondary } (), note )
                ]
            ]

@docs viewEnhancer

-}

import Html
import Html.Attributes exposing (class, style)
import Markdown
import UIExplorer exposing (getCurrentSelectedStory)


{-| This is the part that allows to display notes underneath the view
-}
viewEnhancer : UIExplorer.Model a b { c | note : String } -> Html.Html (UIExplorer.Msg b)
viewEnhancer model =
    case getCurrentSelectedStory model of
        Just ( _, _, option ) ->
            Markdown.toHtml [ class "content uie-text-sm markdown-body", style "width" "100%" ] option.note

        Nothing ->
            Html.text ""
