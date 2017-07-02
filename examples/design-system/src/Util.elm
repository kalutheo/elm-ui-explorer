module Util exposing (..)

import Html exposing (div)
import Storybook.Msg exposing (..)


emptyDiv children =
    div [] [ children ]


emptyMsg =
    (\_ -> Noop)
