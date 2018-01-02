module Model exposing (..)

import Date
import Json.Decode exposing (Decoder, list, string, bool)
import Json.Decode.Pipeline exposing (decode, required, optional)

-- MESSAGES
type Msg =
    UpdateLastReceived DateTimeString
  | UpdateTestResults (Result String (List TestResult))


-- MODELS
type alias DateTimeString = String

type alias TestResult =
  { key: String
  , result: Bool
  , name: String
  , results: List SubTestResult
  }
type alias SubTestResult = 
  { result: Bool
  , name: String
  }

type alias Model =
    { lastReceived: Maybe Date.Date
    , tests: List TestResult }

init : ( Model, Cmd Msg )
init = ( { lastReceived = Nothing, tests = [] }, Cmd.none )


-- DECODERS
testResultsDecoder : Decoder (List TestResult)
testResultsDecoder =
    list testResultDecoder

testResultDecoder : Decoder TestResult
testResultDecoder =
    decode TestResult
        |> required "key" string
        |> required "result" bool
        |> required "name" string
        |> optional "results" (list subTestResultDecoder) []

subTestResultDecoder : Decoder SubTestResult
subTestResultDecoder =
    decode SubTestResult
        |> required "result" bool
        |> required "name" string