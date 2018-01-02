module View exposing (view)

import Model exposing (..)
import AppStyles exposing (..)
import TestResult

import Html exposing (Html)
import Date
import Date.Format

import Element
import Element.Attributes exposing (px, padding, spacing, alignRight, width, height, percent)

-- VIEWS
view : Model -> Html Msg
view model =
    Element.layout stylesheet <| (pageWrapper model)

pageWrapper model =
    Element.column AppStyles.PageStyle
        [ padding 20, spacing 20, height (percent 100) ]
        [ headerArea model.lastReceived
        , contentArea model.tests
        ]

headerArea lastReceived =
    Element.row AppStyles.HeaderStyle
        [ alignRight ]
        [ Element.text "Last result received: "
        , Element.text
            (case lastReceived of
                Nothing -> "<unknown>"
                Just date -> date |> Date.Format.format "%B %e, %Y %H:%M:%S")
        ]

contentArea testResults =
    Element.wrappedRow AppStyles.ContentStyle
        [ spacing 40 ]
        (testResults
            |> List.indexedMap (\index testResult ->
                let
                    testResultConfig = { toggleMsg = ToggleDetails index }
                in
                    TestResult.view testResultConfig testResult))
