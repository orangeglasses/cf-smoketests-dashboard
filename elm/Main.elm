port module Main exposing (..)

import Html exposing (Html, div, button, text, program)
import Json.Decode exposing (Decoder)

-- MODEL
type alias Model = { count: Int }

init : ( Model, Cmd Msg )
init = ( { count = 1 }, Cmd.none )


-- MESSAGES
type Msg = Counter Model


-- VIEW
view : Model -> Html Msg
view model = div [] [ text (toString model.count) ]


-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Counter count -> ( count, Cmd.none )


-- SUBSCRIPTIONS
port updates : (Model -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model = updates Counter


-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
