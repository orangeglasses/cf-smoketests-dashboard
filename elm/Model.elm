module Model exposing (..)

import Date
import Json.Decode exposing (Decoder, list, string, bool)
import Json.Decode.Pipeline exposing (decode, required, optional)
import TestResult


-- MESSAGES
type Msg =
    UpdateLastReceived DateTimeString
  | UpdateTestResults (Result String (List TestResult.TestResult))
  | ToggleDetails Int


-- MODELS
type alias DateTimeString = String

type alias Model =
    { lastReceived: Maybe Date.Date
    , tests: List TestResult.Model }

initialModel : Model
initialModel = { lastReceived = Nothing, tests = [] }

init : ( Model, Cmd Msg )
init = ( initialModel, Cmd.none )


-- DECODERS
-- https://medium.com/@_rchaves_/elm-how-to-use-decoders-for-ports-how-to-not-use-decoders-for-json-a4f95b51473a
testResultsDecoder : Decoder (List TestResult.TestResult)
testResultsDecoder =
    list testResultDecoder

testResultDecoder : Decoder TestResult.TestResult
testResultDecoder =
    decode TestResult.TestResult
        |> required "key" string
        |> required "result" bool
        |> required "name" string
        |> optional "results" (list subTestResultDecoder) []

subTestResultDecoder : Decoder TestResult.SubTestResult
subTestResultDecoder =
    decode TestResult.SubTestResult
        |> required "result" bool
        |> required "name" string