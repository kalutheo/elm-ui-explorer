module App exposing (..)

import Html
    exposing
        ( Html
        , text
        , div
        )
import Html.Attributes exposing (class)
import StoryBook.Model exposing (..)
import StoryBook.Update exposing (..)
import StoryBook.View exposing (viewSidebar, viewHeader)
import Atom.Button as Button exposing (..)
import Atom.Toast as Toast exposing (..)


update : Msg -> Model Msg -> Model Msg
update msg model =
    case msg of
        Noop ->
            model

        SelectStory storyId ->
            { model | selectedStoryId = storyId }


model : Model Msg
model =
    { stories =
        [ { id = CustomButton
          , description = "a simple button"
          , view = Button.story
          }
        , { id = Toast
          , description = "a simple toast"
          , view = Toast.story
          }
        ]
    , selectedStoryId = None
    }


main : Program Never (Model Msg) Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


viewContent : Model Msg -> Html Msg
viewContent model =
    model.stories
        |> List.filter (\story -> story.id == model.selectedStoryId)
        |> List.map .view
        |> List.head
        |> Maybe.withDefault (div [] [ text "A simple storybook POC in ELM" ])


view : Model Msg -> Html Msg
view model =
    div []
        [ viewHeader
        , div [ class "columns is-mobile" ]
            [ viewSidebar model
            , div [ class "column is-three-quarters" ]
                [ viewContent model
                ]
            ]
        ]
