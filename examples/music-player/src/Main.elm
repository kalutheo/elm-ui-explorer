port module Main exposing (main, subscriptions)

import Browser
import Model exposing (..)
import Msg exposing (..)
import Ports exposing (playNext)
import Update exposing (init, update)
import View exposing (view)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always <| playNext (\_ -> Next)
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
