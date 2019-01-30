module AppStyles exposing (stylesheet, DashboardStyles(..), TestResultStyle(..), StatusStyle(..), DetailsStatusStyle(..))

import Model exposing (Model)

import Style exposing (rgba, StyleSheet)
import Style.Border as Border
import Style.Color as Color 
import Style.Font as Font
import Style.Transition as Transition
import Color


type DashboardStyles =
    PageStyle
  | HeaderStyle
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

backgroundColor : Style.Color
backgroundColor = (rgba 37 37 38 255)

testResultBackgroundColor : Style.Color
testResultBackgroundColor = (rgba 46 46 46 255)

statusOKRed : Float
statusOKRed = 233
statusOKGreen : Float
statusOKGreen = 161
statusOKBlue : Float
statusOKBlue = 77
statusBadRed : Float
statusBadRed = 246
statusBadGreen : Float
statusBadGreen = 84
statusBadBlue : Float
statusBadBlue = 83

statusGoodColor : Style.Color
statusGoodColor = (rgba 146 197 105 255)
statusOKColor : Style.Color
statusOKColor = (rgba statusOKRed statusOKGreen statusOKBlue 255)
statusBadColor : Style.Color
statusBadColor = (rgba statusBadRed statusBadGreen statusBadBlue 255)

stylesheet : Model -> StyleSheet DashboardStyles variation
stylesheet model =
    let
        -- Determine gradient for last received text (moves from green to orange to red).
        lastReceivedStatus = model.lastReceived.status
        headerGradient = case lastReceivedStatus of
            Nothing -> statusOKColor
            Just status ->
                if status >= 1 then statusBadColor
                else if status > 0 then
                    let
                        red   = status * (statusBadRed   - statusOKRed) + statusOKRed
                        green = status * (statusBadGreen - statusOKGreen) + statusOKGreen
                        blue  = status * (statusBadBlue  - statusOKBlue) + statusOKBlue
                    in
                        rgba red green blue 255
                else statusGoodColor
    in
        Style.styleSheet
            [ Style.style PageStyle
                [ Color.background backgroundColor
                , Font.typeface [ Font.font "Source Sans Pro", Font.font "Trebuchet MS", Font.font "Lucida Grande", Font.font "Bitstream Vera Sans", Font.font "Helvetica Neue", Font.sansSerif ]
                ]

            , Style.style HeaderStyle
                [ Font.size 30
                , Color.text headerGradient
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
