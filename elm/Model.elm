module Model exposing (..)

import Date


-- MESSAGES
type Msg =
    UpdateLastReceived DateTimeString
  | UpdateSmokeStatus (List {})


-- MODELS
type alias DateTimeString = String
type alias Model =
    { lastReceived: Maybe Date.Date
    , tests: List {} }

init : ( Model, Cmd Msg )
init = ( { lastReceived = Nothing, tests = [] }, Cmd.none )
