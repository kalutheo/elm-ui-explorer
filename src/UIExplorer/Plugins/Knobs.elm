module UIExplorer.Plugins.Knobs exposing
    ( viewEnhancer
    , viewKnobsForUI
    , updateKnobs
    )

{-|


# Knobs

This plugin allows to make stories that are controbale with UI Inputs.

See usage [here](https://github.com/kalutheo/elm-ui-explorer/blob/master/examples/button/ExplorerWithKnobs.elm)

@docs viewEnhancer
@docs viewKnobsForUI
@docs updateKnobs

-}

import Debug.Control
import Html
import UIExplorer exposing (getCurrentSelectedStory)


{-| Display the Controls -
-}
viewKnobsForUI :
    { d | customModel : c }
    -> (Debug.Control.Control a -> b)
    -> (c -> Debug.Control.Control a)
    -> Html.Html (UIExplorer.Msg b)
viewKnobsForUI model onChanged getField =
    Debug.Control.view (UIExplorer.ExternalMsg << onChanged) (getField model.customModel)


{-| Update for knobs model -
-}
updateKnobs : { b | customModel : a } -> c -> (c -> a) -> ( { b | customModel : a }, Cmd msg )
updateKnobs model customModel updateField =
    let
        newModel =
            updateField customModel
    in
    ( { model | customModel = newModel }, Cmd.none )


{-| Knobs view enhancer
-}
viewEnhancer :
    UIExplorer.Model a b { c | knobs : Bool }
    ->
        (UIExplorer.Model a b { c | knobs : Bool }
         -> { c | knobs : Bool }
         -> Html.Html msg
        )
    -> Html.Html msg
viewEnhancer model viewKnobs =
    case getCurrentSelectedStory model of
        Just ( _, _, option ) ->
            if option.knobs then
                Html.div []
                    [ viewKnobs model option
                    ]

            else
                Html.text ""

        Nothing ->
            Html.text ""
