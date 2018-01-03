module AppStyles exposing (..)

import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Color exposing (..)


type DashboardStyles =
    PageStyle
  | HeaderStyle
  | ContentStyle
  | TestResultStyle TestResultStyle
  | TestResultTitleStyle
  | TestResultListStyle
  | TestResultItemStyle TestResultItemStyle

type TestResultStyle =
    Success
  | Failure

type TestResultItemStyle =
    Good
  | OK
  | Bad

stylesheet : StyleSheet DashboardStyles variation
stylesheet =
    Style.styleSheet
        [ Style.style PageStyle
            [ Color.background (rgba 37 37 38 255)
            , Font.typeface [ Font.font "Source Sans Pro", Font.font "Trebuchet MS", Font.font "Lucida Grande", Font.font "Bitstream Vera Sans", Font.font "Helvetica Neue", Font.sansSerif ]
            ]
        , Style.style HeaderStyle
            []
        , Style.style ContentStyle
            []
        , Style.style (TestResultStyle Success)
            [ Color.background (rgba 46 46 46 255)
            , Color.text (rgba 146 197 105 255)
            , Color.border (rgba 146 197 105 255)
            , Border.all 2
            ]
        , Style.style (TestResultStyle Failure)
            [ Color.background (rgba 46 46 46 255)
            , Color.text (rgba 246 84 83 255)
            , Color.border (rgba 246 84 83 255)
            , Border.all 2
            ]
        , Style.style TestResultTitleStyle
            [ Font.size 30 ]
        , Style.style TestResultListStyle
            []
        , Style.style (TestResultItemStyle Good)
            [ Color.text (rgba 146 197 105 255) ]
        , Style.style (TestResultItemStyle OK)
            [ Color.text (rgba 233 161 77 255) ]
        , Style.style (TestResultItemStyle Bad)
            [ Color.text (rgba 246 84 83 255) ]
        ]
