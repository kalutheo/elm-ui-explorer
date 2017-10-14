module Explorer exposing (..)

import Html.Attributes exposing (style)
import Main exposing (view, Model)
import Html exposing (div)
import UIExplorer exposing (app, addUICategory, emptyUICategories, renderStories, createUI)


{--A list of stories that represent all available states of the UI--}


stories : List ( String, Model )
stories =
    [ ( "Default", { isOpen = False } ), ( "Opened", { isOpen = True } ) ]



{--A simple wrapper to prevent description to be hidden by the dropdown --}


viewStoriesWrapper : Model -> Html.Html Main.Msg
viewStoriesWrapper model =
    div [ style [ ( "height", "100px" ) ] ] [ view model ]


main =
    app
        (emptyUICategories
            |> addUICategory
                "Default"
                [ createUI
                    "dropdown"
                    "A dropdown Menu"
                    (renderStories viewStoriesWrapper stories)
                ]
        )
