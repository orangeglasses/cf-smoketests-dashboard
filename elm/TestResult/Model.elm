module TestResult.Model exposing (..)

import Json.Decode exposing (Decoder, list, string, float, bool, nullable)
import Json.Decode.Pipeline exposing (decode, required, optional)



-- MODEL

type alias Model =
  { showDetails: Bool
  , result: TestResult }
type alias TestResult =
  { key: String
  , result: Bool
  , name: String
  , results: List SubTestResult
  }
type alias SubTestResult =
  { result: Bool
  , name: String
  , error: Maybe String
  }

type alias Config msg =
  { toggleMsg: msg }

initialModel : Model
initialModel = { showDetails = False, result = { key = "", result = False, name = "", results = [] } }



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
        |> optional "error" (nullable string) Nothing
