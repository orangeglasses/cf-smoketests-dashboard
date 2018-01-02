module View exposing (view)

import Model exposing (..)
import Html exposing (Html, div, text)
import Date
import Date.Format
import TestResult

view : Model -> Html Msg
view model =
    div []
    [ lastReceivedView model.lastReceived
    , testsView model.tests
    ]

lastReceivedView: (Maybe Date.Date) -> Html Msg
lastReceivedView lastReceived =
    div []
    [ text
        (case lastReceived of
            Nothing -> "Unknown"
            Just date -> date |> Date.Format.format "%B %e, %Y %H:%M:%S") ]

testsView: (List TestResult.Model) -> Html Msg
testsView testResults =
    div
        []
        (testResults
            |> List.indexedMap
                (\index testResult ->
                    let
                        testResultConfig = { toggleMsg = ToggleDetails index }
                    in
                        TestResult.view testResultConfig testResult))
