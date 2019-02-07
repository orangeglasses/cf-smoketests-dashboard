port module Main exposing (..)

import Model exposing (..)
import View
import TestResult.Model as TestResults exposing (initialModel, testResultsDecoder)

import Browser
import Json.Decode exposing (Decoder)
import List.Extra exposing (getAt, updateAt)



-- UPDATE

update : Model.Msg -> Model.Model -> ( Model.Model, Cmd Model.Msg )
update msg model =
    case msg of
        Model.SetNow date ->
            let
                oldLastReceived = model.lastReceived
                newLastReceived =
                    { oldLastReceived | time = Just date }
            in
                ( { model | lastReceived = newLastReceived }, Cmd.none )

        Model.UpdateLastReceived (Ok lastReceived) ->
            ( { model | lastReceived = lastReceived }, Cmd.none )

        Model.UpdateLastReceived (Err err) ->
            ( model, Cmd.none )

        Model.UpdateTestResults (Ok tests) ->
            let
                testResultModels =
                    tests
                    |> List.indexedMap
                        (\i t ->
                        let
                            -- Merge previous showDetails value into new results (or we loose toggle state).
                            previousTestResult = (getAt i <| model.tests) |> Maybe.withDefault TestResults.initialModel
                            showDetails = previousTestResult.showDetails
                        in
                            { showDetails = showDetails, result = t })
            in
                ( { model | tests = testResultModels }, Cmd.none )

        Model.UpdateTestResults (Err err) ->
            ( model, Cmd.none )

        Model.ToggleDetails index ->
            let
                -- Toggle show details in test results.
                updatedTests =
                    updateAt index (\t -> { t | showDetails = not t.showDetails }) <| model.tests
            in
                ( { model | tests = updatedTests }, Cmd.none )



-- SUBSCRIPTIONS

port lastReceiveds : (Json.Decode.Value -> msg) -> Sub msg
port testResults : (Json.Decode.Value -> msg) -> Sub msg

subscriptions : Model.Model -> Sub Model.Msg
subscriptions model =
    Sub.batch
        [ lastReceiveds lastReceivedUpdated
        , testResults (testResultsUpdated model)
        ]

lastReceivedUpdated : Json.Decode.Value -> Model.Msg
lastReceivedUpdated modelJson =
    Model.UpdateLastReceived (Json.Decode.decodeValue lastReceivedDecoder modelJson)

testResultsUpdated : Model.Model -> Json.Decode.Value -> Model.Msg
testResultsUpdated model modelJson =
    Model.UpdateTestResults (Json.Decode.decodeValue TestResults.testResultsDecoder modelJson)
    


-- MAIN

main : Program () Model.Model Model.Msg
main =
    Browser.element
        { init = Model.init
        , view = View.view
        , update = update
        , subscriptions = subscriptions
        }
