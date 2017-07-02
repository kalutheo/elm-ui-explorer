port module Ports exposing (..)

import Model exposing (..)


-- port for sending strings out to JavaScript


port load : Track -> Cmd msg


port loadAndPlay : Track -> Cmd msg


port play : () -> Cmd msg


port pause : () -> Cmd msg


port playNext : (Maybe String -> msg) -> Sub msg
