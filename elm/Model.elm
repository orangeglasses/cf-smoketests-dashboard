module Model exposing (..)

import TestResult.Model as TestResults

import Time exposing (..)
import Iso8601 as Iso exposing (..)
import Json.Decode as Decode exposing (Decoder, Error, list, string, float, bool, nullable, andThen, succeed, fail)
import Parser exposing ((|.), (|=), Parser, andThen, end, int, map, oneOf, succeed, symbol)
import Json.Decode.Pipeline exposing (required, optional, hardcoded)
import Task


-- MESSAGES
type Msg =
    SetNow Time.Posix
  | UpdateLastReceived (Result Error LastReceived)
  | UpdateTestResults (Result Error (List TestResults.TestResult))
  | ToggleDetails Int


-- MODELS
type alias LastReceived =
    { time: Maybe Time.Posix
    , diffText: Maybe String
    , status: Maybe Float
    }

type alias Model =
    { lastReceived: LastReceived
    , tests: List TestResults.Model
    }

initialModel : Model
initialModel = { lastReceived = { time = Nothing, diffText = Nothing, status = Nothing }, tests = [] }

init : () -> ( Model, Cmd Msg )
init flags =
    ( initialModel
    , Time.now |> Task.perform SetNow
    )


-- DECODERS
-- https://medium.com/@_rchaves_/elm-how-to-use-decoders-for-ports-how-to-not-use-decoders-for-json-a4f95b51473a
lastReceivedDecoder : Decoder LastReceived
lastReceivedDecoder =
    Decode.succeed LastReceived
        |> optional "time" (nullable time) Nothing
        |> optional "diffText" (nullable string) Nothing
        |> optional "status" (nullable float) Nothing

time : Decoder Time.Posix
time =
    Decode.string
        |> Decode.andThen
            (\str ->
                case toTime str of
                    Err deadEnds ->
                        Decode.fail <| Parser.deadEndsToString deadEnds

                    Ok t ->
                        Decode.succeed t
            )