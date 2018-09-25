module View exposing (controlsView, playPauseView, trackListView, trackView, view)

import Html exposing (Html, div, i, li, text, ul)
import Html.Attributes exposing (attribute, class, classList)
import Html.Events exposing (onClick)
import Model exposing (Model, Track)
import Msg exposing (..)
import Utils exposing (..)


trackView : Int -> Track -> Bool -> Html Msg
trackView index track isSelected =
    let
        classNames =
            classList [ ( "TrackSelected", isSelected ) ]
    in
    li [ class "TrackItem", onClick <| SelectTrack track, classNames ]
        [ div [ class "TrackNumber" ]
            [ Html.text <| String.fromInt (index + 1) ]
        , div [ class "TrackTitle" ]
            [ Html.text <| track.name ]
        , div [ class "TrackDuration" ]
            [ Html.text <| (track.duration |> toFloat |> msToTime) ]
        ]


playPauseView : Model -> Html Msg
playPauseView model =
    if model.isPlaying then
        i [ class "ControlIcon fa fa-fw fa-pause", onClick Pause ]
            []

    else
        i [ class "ControlIcon fa fa-fw fa-play", onClick Play ]
            []


trackListView : Model -> Html Msg
trackListView model =
    let
        isSelected track =
            Maybe.map (\selectedTrack -> selectedTrack == track) model.selectedTrack
                |> Maybe.withDefault False

        listItem =
            \i track ->
                trackView i track (isSelected track)
    in
    ul [ class "TrackList" ] (List.indexedMap listItem model.album.playlist)


controlsView : Model -> Html Msg
controlsView model =
    div [ class "Artwork", attribute "style" "background-image: url('https://i.scdn.co/image/d025af49bb84dbb26393f42ff9646f1c748c3035');" ]
        [ div [ class "Controls" ]
            [ i [ class "ControlIcon", Html.Attributes.class "fa fa-fw fa-fast-backward", onClick Previous ]
                []
            , playPauseView model
            , i [ class "ControlIcon", Html.Attributes.class "fa fa-fw fa-fast-forward", onClick Next ]
                []
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "App" ]
        [ controlsView model
        , trackListView model
        ]
