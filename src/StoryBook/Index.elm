module StoryBook.Index exposing (storybook)

{-|

This library helps you create a simple storybook

# Storybook
@docs storybook

-}

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
            { model | selectedStoryId = Just storyId, selectedStateId = Nothing }


{-| Generates a storybook Applicaton
    storybook stories
-}
storybook : Stories Msg -> Program Never (Model Msg) Msg
storybook stories =
    let
        model =
            { stories = stories
            , selectedStoryId = Nothing
            , selectedStateId = Nothing
            }
    in
        Html.beginnerProgram
            { model = model
            , view = view
            , update = update
            }
