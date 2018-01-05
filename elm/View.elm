module View exposing (view)

import AppStyles exposing (..)
import Model exposing (..)
import TestResult.Model as TestResults exposing (..)
import TestResult.View as TestResults exposing (..)

import Html exposing (Html)
import Element
import Element.Attributes exposing (px, padding, spacing, alignRight, width, height, percent)



-- VIEWS

view : Model.Model -> Html Msg
view model =
    Element.layout stylesheet <| (pageWrapper model)


pageWrapper : Model.Model -> Element.Element DashboardStyles variation Msg
pageWrapper model =
    Element.column AppStyles.PageStyle
        [ padding 20, spacing 40, height (percent 100) ]
        [ headerArea model.lastReceived
        , contentArea model.tests
        ]


headerArea : LastReceived -> Element.Element DashboardStyles variation Msg
headerArea lastReceived =
    let
        headerStyle =
            case lastReceived.status of
                Nothing -> OK
                Just status ->
                    if status >= 1 then Bad
                    else if status > 0 then OK
                    else Good
    in
        Element.row (AppStyles.HeaderStyle headerStyle)
            [ alignRight ]
            [ Element.text
                (case lastReceived.diffText of
                    Nothing -> "<unknown>"
                    Just string -> string)
            , Element.text
                (case lastReceived.diffText of
                    Nothing -> ""
                    Just string -> " ago")
            ]


contentArea : List TestResults.Model -> Element.Element DashboardStyles variation Msg
contentArea testResults =
    Element.wrappedRow AppStyles.ContentStyle
        [ spacing 40 ]
        (testResults
            |> List.indexedMap (\index testResult ->
                let
                    testResultConfig = { toggleMsg = ToggleDetails index }
                in
                    TestResults.view testResultConfig testResult))
