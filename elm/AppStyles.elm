module AppStyles exposing (..)

import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Transition as Transition
import Color exposing (..)


type DashboardStyles =
    PageStyle
  | HeaderStyle StatusStyle
  | ContentStyle
  | TestResultStyle TestResultStyle
  | TestResultTitleStyle DetailsStatusStyle
  | TestResultListStyle
  | TestResultItemStyle StatusStyle

type TestResultStyle =
    Success
  | Failure

type StatusStyle =
    Good
  | OK
  | Bad

type DetailsStatusStyle =
    DetailsShown
  | DetailsHidden

backgroundColor : Color
backgroundColor = (rgba 37 37 38 255)

testResultBackgroundColor : Color
testResultBackgroundColor = (rgba 46 46 46 255)
statusGoodColor : Color
statusGoodColor = (rgba 146 197 105 255)
statusOKColor : Color
statusOKColor = (rgba 233 161 77 255)
statusBadColor : Color
statusBadColor = (rgba 246 84 83 255)

stylesheet : StyleSheet DashboardStyles variation
stylesheet =
    Style.styleSheet
        [ Style.style PageStyle
            [ Color.background backgroundColor
            , Font.typeface [ Font.font "Source Sans Pro", Font.font "Trebuchet MS", Font.font "Lucida Grande", Font.font "Bitstream Vera Sans", Font.font "Helvetica Neue", Font.sansSerif ]
            ]

        , Style.style (HeaderStyle Good)
            [ Font.size 30
            , Color.text statusGoodColor
            ]

        , Style.style (HeaderStyle OK)
            [ Font.size 30
            , Color.text statusOKColor
            ]

        , Style.style (HeaderStyle Bad)
            [ Font.size 30
            , Color.text statusBadColor
            ]

        , Style.style ContentStyle
            []

        , Style.style (TestResultStyle Success)
            [ Color.background testResultBackgroundColor
            , Color.text statusGoodColor
            , Color.border statusGoodColor
            , Border.all 2
            ]

        , Style.style (TestResultStyle Failure)
            [ Color.background testResultBackgroundColor
            , Color.text statusBadColor
            , Color.border statusBadColor
            , Border.all 2
            ]

        , Style.style (TestResultTitleStyle DetailsShown)
            [ Font.size 30
            , Transition.all
            ]

        , Style.style (TestResultTitleStyle DetailsHidden)
            [ Font.size 50
            , Transition.all
            ]

        , Style.style TestResultListStyle
            []

        , Style.style (TestResultItemStyle Good)
            [ Color.text statusGoodColor
            ]

        , Style.style (TestResultItemStyle OK)
            [ Color.text statusOKColor
            ]

        , Style.style (TestResultItemStyle Bad)
            [ Color.text statusBadColor
            ]
        ]
