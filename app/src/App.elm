module App exposing (..)

import Html
    exposing
        ( Html
        , a
        , h1
        , h2
        , h3
        , text
        , i
        , div
        , span
        , aside
        , button
        , header
        , nav
        , section
        , ul
        , li
        )
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import StoryBook.Model exposing (..)
import StoryBook.Update exposing (..)
import Atom.Button as Button exposing (..)
import Atom.Toast as Toast exposing (..)
import Elegant exposing (..)


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


viewMenu : Stories -> Html Msg
viewMenu stories =
    aside [ class "menu" ]
        [ ul [ class "menu-list" ]
            (List.map
                (\story ->
                    li []
                        [ a [ onClick (SelectStory story) ]
                            [ text (story.id |> toString) ]
                        ]
                )
                stories
            )
        ]


viewContent : Model -> Html Msg
viewContent model =
    case model.selectedStoryId of
        CustomButton ->
            Button.story

        Toast ->
            Toast.story

        _ ->
            div [] [ text "A simple storybook POC in ELM" ]


viewHeader : Html msg
viewHeader =
    section
        [ class "hero is-primary"
        , style
            [ height (Px 100), paddingTop (Px 20) ]
        ]
        [ div []
            [ div [ class "container" ]
                [ h1 [ class "title" ]
                    [ text "ELM" ]
                , h2 [ class "subtitle" ]
                    [ text "Storybook" ]
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ viewHeader
        , div [ class "columns" ]
            [ div [ class "column" ]
                [ viewMenu model.stories ]
            , div [ class "column is-three-quarters" ]
                [ viewContent model
                ]
            ]
        ]
