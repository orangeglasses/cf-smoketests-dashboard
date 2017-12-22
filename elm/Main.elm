port module Main exposing (..)

import Html exposing (Html, div, button, text, program)
import Date exposing (fromString)
import Date.Format

-- MODEL
type alias DateTimeString = String
type alias Model =
    { lastReceived: Maybe Date.Date }

init : ( Model, Cmd Msg )
init = ( { lastReceived = Nothing }, Cmd.none )


-- MESSAGES
type Msg =
    UpdateLastReceived DateTimeString


-- VIEW
view : Model -> Html Msg
view model =
    div []
    [ text (case model.lastReceived of
                Nothing -> "Unknown"
                Just date -> date |> Date.Format.format "%B %e, %Y %H:%M:%S") ]


-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateLastReceived dateTimeString ->
            let
                dateTime = dateTimeString |> Date.fromString |> Result.toMaybe
            in
                ( { model | lastReceived = dateTime }, Cmd.none )


-- SUBSCRIPTIONS
port lastReceiveds : (DateTimeString -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model = lastReceiveds UpdateLastReceived


-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
