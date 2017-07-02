port module Main exposing (..)

import View exposing (view)
import Html as App
import Update exposing (init, update)
import Msg exposing (..)
import Model exposing (..)
import Ports exposing (playNext)


main : Program Never Model Msg
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always <| playNext (\str -> Next)
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
