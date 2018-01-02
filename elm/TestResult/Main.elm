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

type alias Config msg =
  { toggleMsg: msg }

initialModel: Model
initialModel = { showDetails = False, result = { key = "", result = False, name = "", results = [] } }


-- VIEW
view : Config msg -> Model -> Html msg
view config model =
    div
    [ style [("background-color", "red")], onMouseEnter config.toggleMsg, onMouseLeave config.toggleMsg] [ text (toString model)
    ]
