module View exposing (view)

import Model exposing (..)
import TestResult.Model as TestResults exposing (..)

import Html exposing (Html, h1, div, span, text, header, section)
import Html.Attributes exposing (classList)

-- VIEWS

view : Model.Model -> Html Msg
view model =
    div [ classList [("app", True)] ] [
        header [ classList [("header", True)] ] [
            lastReceivedTime model.lastReceived
        ]
        , tests model.tests
        , div [] []
    ]

lastReceivedTime : LastReceived -> Html Msg
lastReceivedTime lastReceived =
    let
        status = (Maybe.withDefault 100 (lastReceived.status))
    in
        div [ classList[ ("statusbar", True) ]] [
            div [ classList[("system-state", True), ("state-warning", status > 50), ("state-critical", status > 75)]] [ ]
            , div [ classList[("last-received-time", True)] ] [
                text "Last state change was "
                , text (Maybe.withDefault "? seconds" (lastReceived.diffText))
                , text " ago"
            ]
        ]

tests : List TestResults.Model -> Html Msg
tests results =
    results
        |> List.map (\r -> div [ classList [ ("test-container", True), ("failing", r.result.result /= True) ]] [ 
            h1 [ classList [ ("test-name", True) ] ] [ text r.result.name ] 
            , testOutput r.result.results
             ])
        |> section [ classList [("tests", True)]]

testOutput : List SubTestResult -> Html Msg
testOutput testResults =
    testResults
        |> List.map (\tr -> div [ classList [ ("test-result", True) ]] [ 
            div [ classList [ ("result-name", True)] ] [ text tr.name ]
            , div [ classList [ ("has-error", tr.error /= Nothing), ("result-error", True)] ] [ 
                text (Maybe.withDefault "" (tr.error))
                ]
            ])
        |> div [ classList [("test", True)]]

