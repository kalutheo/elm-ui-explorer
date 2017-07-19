module StoryBook.Model exposing (..)

{-|

Storybook datastructures

# Story
@docs Story

# Stories
@docs Stories

# Model
@docs Model
-}

import Html exposing (Html)


{-| Item used to describe a Story
-}
type alias Story msg =
    { id : String
    , description : String
    , view : Maybe String -> Html msg
    }


{-| Item used to describe a List of stories
-}
type alias Stories msg =
    List (Story msg)


{-| Model of the storybook
-}
type alias Model msg =
    { stories : Stories msg
    , selectedStoryId : Maybe String
    , selectedStateId : Maybe String
    }
