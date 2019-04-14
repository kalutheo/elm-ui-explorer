module UIExplorer.Plugins.Note exposing (PluginModel, WithNotes, addNote, viewEnhancer)

import Html
import Html.Attributes exposing (class, style)
import Markdown
import UIExplorer exposing (ViewEnhancer, explore, getCurrentSelectedStory)


type alias PluginModel =
    { text : String
    }


addNote : String -> PluginModel
addNote text =
    { text = text
    }


type alias WithNotes a =
    { a | notes : PluginModel }


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
