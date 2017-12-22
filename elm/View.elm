module View exposing (view)

import Model exposing (..)
import Html exposing (Html, div, text)
import Date
import Date.Format

view : Model -> Html Msg
view model =
    div []
    [ lastReceivedView model.lastReceived
    , testsView model.tests
    ]

lastReceivedView: (Maybe Date.Date) -> Html msg
lastReceivedView lastReceived =
    text
        (case lastReceived of
            Nothing -> "Unknown"
            Just date -> date |> Date.Format.format "%B %e, %Y %H:%M:%S")

testsView: (List TestResult) -> Html msg
testsView testResults =
    div [] (testResults |> List.map testView)

testView: TestResult -> Html msg
testView testResult =
    div [] [ text (toString testResult) ]