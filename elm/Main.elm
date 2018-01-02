port module Main exposing (..)

import Model exposing (..)
import View
import TestResult

import Html exposing (Html, div, button, text, program)
import Date exposing (fromString)
import Json.Decode exposing (Decoder, list, string, bool)
import Json.Decode.Pipeline exposing (decode, required, optional)
import List.Extra exposing (getAt, updateAt)



-- UPDATE
update : Model.Msg -> Model.Model -> ( Model.Model, Cmd Model.Msg )
update msg model =
    case msg of
        Model.UpdateLastReceived dateTimeString ->
            updateLastReceived dateTimeString model

        Model.UpdateTestResults (Ok tests) ->
            let
                testResultModels =
                    tests
                    |> List.indexedMap
                        (\i t ->
                        let
                            -- Merge previous showDetails value into new results (or we loose toggle state).
                            previousTestResult = (getAt i <| model.tests) |> Maybe.withDefault TestResult.initialModel
                            showDetails = previousTestResult.showDetails
                        in
                            { showDetails = showDetails, result = t })
            in
                ( { model | tests = testResultModels }, Cmd.none )

        Model.UpdateTestResults (Err err) ->
            ( model, Cmd.none )

        Model.ToggleDetails index ->
            let
                updatedTests =
                    updateAt index (\t -> { t | showDetails = not t.showDetails }) <| model.tests
            in
                ( { model | tests = updatedTests }, Cmd.none )


updateLastReceived : String -> Model.Model -> ( Model.Model, Cmd Model.Msg )
updateLastReceived dateTimeString model =
    let
        dateTime = dateTimeString |> Date.fromString |> Result.toMaybe
    in
        ( { model | lastReceived = dateTime }, Cmd.none )



-- SUBSCRIPTIONS
port lastReceiveds : (Model.DateTimeString -> msg) -> Sub msg
port testResults : (Json.Decode.Value -> msg) -> Sub msg

subscriptions : Model.Model -> Sub Model.Msg
subscriptions model =
    Sub.batch
        [ lastReceiveds Model.UpdateLastReceived
        , testResults (testResultsUpdated model)
        ]

testResultsUpdated : Model.Model -> Json.Decode.Value -> Model.Msg
testResultsUpdated model modelJson =
    Model.UpdateTestResults (Json.Decode.decodeValue testResultsDecoder modelJson)
    


-- MAIN
main : Program Never Model.Model Model.Msg
main =
    program
        { init = Model.init
        , view = View.view
        , update = update
        , subscriptions = subscriptions
        }
