module Utils exposing (addLeadingZero, findIndex, getCurrentTrackIndex, msToTime, nextTrack, oneOf, previousTrack)

import Array
import Model exposing (..)


oneOf : List (Maybe a) -> Maybe a
oneOf maybes =
    case maybes of
        [] ->
            Nothing

        maybe :: rest ->
            case maybe of
                Nothing ->
                    oneOf rest

                Just _ ->
                    maybe


getCurrentTrackIndex selectedTrack playlist =
    findIndex
        (\t ->
            case selectedTrack of
                Nothing ->
                    False

                Just track ->
                    t == track
        )
    <|
        Array.fromList playlist


nextTrack : Maybe Track -> PlayList -> Maybe Track
nextTrack selectedTrack playlist =
    let
        albums =
            Array.fromList playlist
    in
    case getCurrentTrackIndex selectedTrack playlist of
        Nothing ->
            Nothing

        Just index ->
            oneOf [ Array.get (index + 1) albums, Array.get 0 albums ]


previousTrack : Maybe Track -> PlayList -> Maybe Track
previousTrack selectedTrack playlist =
    let
        albums =
            Array.fromList playlist
    in
    case getCurrentTrackIndex selectedTrack playlist of
        Nothing ->
            Nothing

        Just index ->
            oneOf [ Array.get (index - 1) albums, Array.get (List.length playlist - 1) albums ]


findIndex pred arr =
    let
        findIndexStartingAt i =
            Array.get i arr
                |> Maybe.andThen
                    (\elem ->
                        if pred elem then
                            Just i

                        else
                            findIndexStartingAt (i + 1)
                    )
    in
    findIndexStartingAt 0


addLeadingZero : Int -> String
addLeadingZero value =
    if value < 10 then
        "0" ++ (value |> String.fromInt)

    else
        value |> String.fromInt


msToTime : Float -> String
msToTime duration =
    let
        seconds =
            (duration / 1000 |> round) |> remainderBy 60

        minutes =
            (duration / (1000 * 60) |> round) |> remainderBy 60
    in
    addLeadingZero minutes ++ ":" ++ addLeadingZero seconds
