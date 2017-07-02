module View exposing (..)

import Html exposing (text, Html, div, i, ul, li)
import Html.Attributes exposing (class, attribute, id, classList)
import Html.Events exposing (onClick)
import Msg exposing (..)
import Model exposing (Model, Track)
import String.Extra exposing (ellipsis)
import Utils exposing (..)


trackView : Int -> Track -> Bool -> Html Msg
trackView index track isSelected =
    let
        classNames =
            classList [ ( "selected", isSelected ) ]
    in
        li [ onClick <| SelectTrack track, classNames ]
            [ div [ class "number" ]
                [ text <| toString (index + 1) ]
            , div [ class "title" ]
                [ text <| ellipsis 28 track.name ]
            , div [ class "duration" ]
                [ text <| (track.duration |> toFloat |> msToTime) ]
            ]


playPauseView : Model -> Html Msg
playPauseView model =
    if model.isPlaying then
        i [ class "fa fa-fw fa-pause", id "pause", onClick Pause ]
            []
    else
        i [ class "fa fa-fw fa-play", id "play", onClick Play ]
            []


trackListView : Model -> Html Msg
trackListView model =
    let
        isSelected track =
            Maybe.map (\selectedTrack -> selectedTrack == track) model.selectedTrack
                |> Maybe.withDefault False

        listItem =
            (\i track ->
                trackView i track (isSelected track)
            )
    in
        ul [ class "TrackList" ] (List.indexedMap listItem model.album.playlist)


view : Model -> Html Msg
view model =
    div [ class "App", attribute "data-reactroot" "" ]
        [ div [ class "Artwork", attribute "style" "background-image: url('https://i.scdn.co/image/d025af49bb84dbb26393f42ff9646f1c748c3035');" ]
            [ div [ class "Controls" ]
                [ i [ class "fa fa-fw fa-fast-backward", onClick Previous ]
                    []
                , playPauseView model
                , i [ class "fa fa-fw fa-fast-forward", onClick Next ]
                    []
                ]
            ]
        , trackListView model
        ]
