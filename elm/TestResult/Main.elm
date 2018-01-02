module TestResult exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onMouseEnter, onMouseLeave, onClick)
import Html.Attributes exposing (style)


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
  }

initialModel: Model
initialModel = { showDetails = False, result = { key = "", result = False, name = "", results = [] } }


-- MESSAGES
type Msg =
    ToggleDetails


-- VIEW
view : Model -> Html Msg
view model =
    div
    [ style [("background-color", "red")], onMouseEnter ToggleDetails, onMouseLeave ToggleDetails, onClick ToggleDetails] [ text (toString model)
    , button [Html.Events.onClick ToggleDetails] [text (toString model.showDetails)]
    ]


-- UPDATE
update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ToggleDetails ->
            ( { model | showDetails = not model.showDetails }, Cmd.none)
