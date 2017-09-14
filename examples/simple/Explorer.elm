module Explorer exposing (..)

import UIExplorer exposing (storybook, renderStory)
import Html.Attributes exposing (style)
import Main exposing (view, Model)
import Html exposing (div)


{--A list of stories that represent all available states of the UI--}


stories : List ( String, Model )
stories =
    [ ( "Default", { isOpen = False } ), ( "Opened", { isOpen = True } ) ]



{--A simple wrapper to prevent description to be hidden by the dropdown --}


viewStoriesWrapper : Model -> Html.Html Main.Msg
viewStoriesWrapper model =
    div [ style [ ( "height", "100px" ) ] ] [ view model ]



{--Displays the list of stories --}


viewStories config =
    renderStory config viewStoriesWrapper stories



{--Runs the UIExplorer App with a given UI collection--}


main =
    storybook
        [ ( "Default"
          , [ { id = "dropdown"
              , description = "A dropdown Menu"
              , view = viewStories
              }
            ]
          )
        ]
