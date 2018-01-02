module View exposing (view)

import Model exposing (..)
import AppStyles exposing (..)
import TestResult

import Html exposing (Html)
import Date
import Date.Format

import Element

-- VIEWS
view : Model -> Html Msg
view model =
    Element.layout stylesheet <| (pageWrapper model)

pageWrapper model =
    Element.column AppStyles.PageStyle
        []
        [ headerArea model.lastReceived
        , contentArea model.tests
        ]

headerArea lastReceived =
    Element.el AppStyles.HeaderStyle
        []
        ( Element.text
            (case lastReceived of
                Nothing -> "Unknown"
                Just date -> date |> Date.Format.format "%B %e, %Y %H:%M:%S") )

contentArea testResults =
    Element.wrappedRow AppStyles.ContentStyle
        []
        (testResults
            |> List.indexedMap (\index testResult ->
                let
                        testResultConfig = { toggleMsg = ToggleDetails index }
                    in
                        TestResult.view testResultConfig testResult))
