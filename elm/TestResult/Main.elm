module TestResult exposing (..)

import AppStyles exposing (..)

import Element
import Element.Events exposing (onMouseEnter, onMouseLeave)

    

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
view : Config msg -> Model -> Element.Element AppStyles.DashboardStyles variation msg
view config model =
    Element.el TestResultStyle
        [ onMouseEnter config.toggleMsg, onMouseLeave config.toggleMsg ]
        (Element.text (toString model))
