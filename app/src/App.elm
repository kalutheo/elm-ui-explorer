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
import Atom.Button as Button
import Atom.Toast as Toast
import Atom.Collapsible as Collapsible


update : Msg -> Model Msg -> Model Msg
update msg model =
    case msg of
        Noop ->
            model

        SelectStory storyId ->
            { model | selectedStoryId = Just storyId }


model : Model Msg
model =
    { stories =
        [ { id = "Collapsible"
          , description = "a simple collapsible"
          , view = Collapsible.story
          }
        , { id = "CustomButton"
          , description = "a simple button"
          , view = Button.story
          }
        , { id = "Toast"
          , description = "a simple toast"
          , view = Toast.story
          }
        ]
    , selectedStoryId = Nothing
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
        |> List.filter
            (\story ->
                case model.selectedStoryId of
                    Just id ->
                        story.id == id

                    Nothing ->
                        False
            )
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
