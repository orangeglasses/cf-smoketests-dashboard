module Model exposing (..)

import Date
import Json.Decode exposing (Decoder, list, string, float, bool, nullable, andThen, succeed, fail)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Task
import TestResult


-- MESSAGES
type Msg =
    SetNow Date.Date
  | UpdateLastReceived (Result String LastReceived)
  | UpdateTestResults (Result String (List TestResult.TestResult))
  | ToggleDetails Int


-- MODELS
type alias LastReceived =
    { time: Maybe Date.Date
    , diffText: Maybe String
    , status: Maybe Float
    }

type alias Model =
    { lastReceived: LastReceived
    , tests: List TestResult.Model
    }

initialModel : Model
initialModel = { lastReceived = { time = Nothing, diffText = Nothing, status = Nothing }, tests = [] }

init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Date.now |> Task.perform SetNow
    )


-- DECODERS
-- https://medium.com/@_rchaves_/elm-how-to-use-decoders-for-ports-how-to-not-use-decoders-for-json-a4f95b51473a
lastReceivedDecoder : Decoder LastReceived
lastReceivedDecoder =
    decode LastReceived
        |> optional "time" (nullable date) Nothing
        |> optional "diffText" (nullable string) Nothing
        |> optional "status" (nullable float) Nothing


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

-- https://www.brianthicks.com/post/2017/01/13/create-custom-json-decoders-in-elm-018/
-- https://github.com/circuithub/elm-json-extra/blob/master/src/Json/Decode/Extra.elm
date : Decoder Date.Date
date =
    let
        convert : String -> Decoder Date.Date
        convert raw =
            case Date.fromString raw of
                Ok date -> succeed date
                Err error -> fail error 
    in
        string |> andThen convert