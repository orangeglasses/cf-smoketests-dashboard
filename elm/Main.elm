port module Main exposing (..)

import Model exposing (..)
import View

import Html exposing (Html, div, button, text, program)
import Date exposing (fromString)


-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateLastReceived dateTimeString ->
            updateLastReceived dateTimeString model
        UpdateSmokeStatus list ->
            ( { model | lastReceived = "" |> Date.fromString |> Result.toMaybe }, Cmd.none )

updateLastReceived : String -> Model -> ( Model, Cmd Msg )
updateLastReceived dateTimeString model =
    let
        dateTime = dateTimeString |> Date.fromString |> Result.toMaybe
    in
        ( { model | lastReceived = dateTime }, Cmd.none )


-- SUBSCRIPTIONS
port lastReceiveds : (DateTimeString -> msg) -> Sub msg
port smokeStatuses : (List {} -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ lastReceiveds UpdateLastReceived
        , smokeStatuses UpdateSmokeStatus
        ]


-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = View.view
        , update = update
        , subscriptions = subscriptions
        }
