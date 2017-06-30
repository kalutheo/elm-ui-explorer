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


update : Msg -> Model -> Model
update msg model =
    case msg of
        Noop ->
            model

        SelectStory story ->
            { model | selectedStoryId = story.id }


model : Model
model =
    { stories =
        [ { id = CustomButton
          , description = "a simple button"
          }
        , { id = Toast
          , description = "a simple toast"
          }
        ]
    , selectedStoryId = None
    }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


viewContent : Model -> Html Msg
viewContent model =
    case model.selectedStoryId of
        CustomButton ->
            Button.story

        Toast ->
            Toast.story

        _ ->
            div [] [ text "A simple storybook POC in ELM" ]


view : Model -> Html Msg
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
