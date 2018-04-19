module Atom.Logo.Index exposing (..)

import Html exposing (img)
import Html.Attributes exposing (alt, height, src, width)


view model =
    img
        [ src "http://bulma.io/images/bulma-logo.png", alt "Bulma: a modern CSS framework based on Flexbox", width 112, height 28 ]
        []
