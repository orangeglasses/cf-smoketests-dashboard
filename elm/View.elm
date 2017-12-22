module View exposing (view, lastReceived)

import Model exposing (..)
import Html exposing (Html, div, text)
import Date.Format

view : Model -> Html Msg
view model =
    div []
    [ lastReceived model ]

lastReceived: Model -> Html msg
lastReceived model =
    text
        (case model.lastReceived of
            Nothing -> "Unknown"
            Just date -> date |> Date.Format.format "%B %e, %Y %H:%M:%S")