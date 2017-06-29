module StoryBook.Model exposing (..)


type alias Story =
    { id : StoryId
    , description : String
    }


type alias Stories =
    List Story


type alias Model =
    { stories : Stories
    , selectedStoryId : StoryId
    }


type StoryId
    = CustomButton
    | Toast
    | None
