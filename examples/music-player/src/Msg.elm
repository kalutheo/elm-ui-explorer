module Msg exposing (..)

import Model exposing (Track)


type Msg
    = Next
    | Play
    | Pause
    | Previous
    | SelectTrack Track
