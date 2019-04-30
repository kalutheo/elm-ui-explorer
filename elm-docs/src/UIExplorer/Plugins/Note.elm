module UIExplorer.Plugins.Note exposing
    ( PluginModel
    , WithNotes
    , addNote
    , viewEnhancer
    )

{-|


# Note Plugin

This plugin enables contextual notes for each story.
It can be used to display some nice markdown content to document your UI.

Example:

    note =
        { notes = addNote """
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

@docs PluginModel
@docs WithNotes
@docs addNote
@docs viewEnhancer

-}

import Html
import Html.Attributes exposing (class, style)
import Markdown
import UIExplorer exposing (ViewEnhancer, explore, getCurrentSelectedStory)


{-| The Type used to store notes for each story
-}
type alias PluginModel =
    { text : String
    }


{-| Simple helper to create a note from a string
-}
addNote : String -> PluginModel
addNote text =
    { text = text
    }


{-| Extensible model that can be used in your Explorer app
-}
type alias WithNotes a =
    { a | notes : PluginModel }


{-| This is the part that allows to display information underneath the view
-}
viewEnhancer : ViewEnhancer {} () (WithNotes a)
viewEnhancer model storiesView =
    let
        note =
            case getCurrentSelectedStory model of
                Just ( _, _, option ) ->
                    Markdown.toHtml [ class "content uie-text-sm" ] option.notes.text

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
