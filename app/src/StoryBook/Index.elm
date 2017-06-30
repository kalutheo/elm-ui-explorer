module StoryBook.Index exposing (..)

import Html exposing (Html)
import StoryBook.Model exposing (..)
import Storybook.Msg exposing (..)
import StoryBook.View exposing (view)


update : Msg -> Model Msg -> Model Msg
update msg model =
    case msg of
        Noop ->
            model

        SelectState stateId ->
            { model | selectedStateId = Just stateId }

        SelectStory storyId ->
            { model | selectedStoryId = Just storyId }


storybook : Model Msg -> Program Never (Model Msg) Msg
storybook model =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
