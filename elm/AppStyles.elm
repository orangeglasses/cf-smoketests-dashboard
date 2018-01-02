module AppStyles exposing (..)

import Style exposing (..)


type DashboardStyles =
    PageStyle
  | HeaderStyle
  | ContentStyle
  | TestResultStyle

stylesheet : StyleSheet DashboardStyles bla
stylesheet =
    Style.styleSheet
        []
