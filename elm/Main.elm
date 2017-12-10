port module Main exposing (..)

import Html exposing (Html, div, button, text, program)
import Html.Events exposing (onClick)
import Random


-- MODEL
type alias Model =
    Int

init : ( Model, Cmd Msg )
init =
    ( 1, Cmd.none )


-- MESSAGES
type Msg
    = Counter Int


-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ text (toString model)
        ]


-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Counter count ->
            ( count, Cmd.none )


-- SUBSCRIPTIONS
port updates : (Int -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
    updates Counter


-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
