module ExplorerNotesPlugin exposing (PluginModel, addNote, viewEnhancer)

import Html
import Html.Attributes exposing (class, style)
import Markdown
import UIExplorer exposing (ViewEnhancer, explore, findStory)


type alias PluginModel =
    { text : String
    }


addNote : String -> PluginModel
addNote text =
    { text = text
    }


join : Maybe (Maybe a) -> Maybe a
join mx =
    case mx of
        Just x ->
            x

        Nothing ->
            Nothing


type alias WithNotes a =
    { a | notes : PluginModel }


viewEnhancer : ViewEnhancer {} () (WithNotes a)
viewEnhancer model storiesView =
    let
        r =
            Maybe.map2 (\a b -> ( a, b )) model.selectedUIId model.selectedStoryId

        maybeStory =
            Maybe.map (\( a, b ) -> findStory a b model.categories) r
                |> join

        note =
            case maybeStory of
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
