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

    main : UIExplorerProgram {} () PluginOption
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
import UIExplorer exposing (ViewEnhancer, explore, getCurrentSelectedStory)


{-| The Type used to store notes for each story
-}
type alias PluginModel a =
    { a
        | note : String
    }


{-| This is the part that allows to display information underneath the view
-}
viewEnhancer : ViewEnhancer {} () (PluginModel a)
viewEnhancer model storiesView =
    let
        note =
            case getCurrentSelectedStory model of
                Just ( _, _, option ) ->
                    Markdown.toHtml [ class "content uie-text-sm" ] option.note

                Nothing ->
                    Html.text ""
    in
    Html.div []
        [ storiesView
        , Html.br [] []
        , Html.hr [ style "height" "1px" ] []
        , Html.br [] []
        , note
        ]
