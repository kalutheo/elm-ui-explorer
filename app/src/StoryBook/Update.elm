module StoryBook.Update exposing (..)

import Storybook.Message exposing (..)
import Storybook.Model exposing (..)


runUpdate : Msg -> Model Msg -> Model Msg
runUpdate msg model =
    case msg of
        Noop ->
            model

        SelectState stateId ->
            { model | selectedStateId = Just stateId }

        SelectStory storyId ->
            { model | selectedStoryId = Just storyId }
