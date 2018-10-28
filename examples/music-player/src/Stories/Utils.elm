module Stories.Utils exposing (withElmUi)

import Element


withElmUi view model =
    Element.layout [] (view model)
