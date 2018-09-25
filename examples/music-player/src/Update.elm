module Update exposing (init, update)

import Array
import Model exposing (Model, model)
import Msg exposing (..)
import Ports exposing (load, loadAndPlay, pause, play)
import Utils exposing (nextTrack, previousTrack)


init : () -> ( Model, Cmd Msg )
init _ =
    let
        firstTrack =
            model.album.playlist
                |> Array.fromList
                |> Array.get 0
    in
    case firstTrack of
        Nothing ->
            ( model, Cmd.none )

        Just track ->
            ( { model | selectedTrack = Just track }, load track )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectTrack track ->
            ( { model | isPlaying = True, selectedTrack = Just track }, loadAndPlay track )

        Play ->
            ( { model | isPlaying = True }, play () )

        Pause ->
            ( { model | isPlaying = False }, pause () )

        Next ->
            case nextTrack model.selectedTrack model.album.playlist of
                Nothing ->
                    ( model, Cmd.none )

                Just track ->
                    update (SelectTrack track) model

        Previous ->
            case previousTrack model.selectedTrack model.album.playlist of
                Nothing ->
                    ( model, Cmd.none )

                Just track ->
                    update (SelectTrack track) model
