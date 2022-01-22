{-
  To execute this program, paste the content of this file
  to http://elm-lang.org/try or https://ellie-app.com and press "compile".
-}

module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes as A exposing (..)
import Html.Events exposing (onInput)
import String
import List


main =
  Browser.sandbox { init = initModel, view = view, update = update }

initModel : Int
initModel = 15

update : Int -> Int -> Int
update msg model = msg

view model =
  div []
    [
      slider { makeMsg = identity, minValue = 1, maxValue = 20, model = model }
    , text ("size = " ++ String.fromInt model)
    , tableFromLines (circleLines model)
    ]

circleLines : Int -> List (List String)
circleLines size =
  let
    circleLine i = List.map (circleCell i) (List.range 1 (2*size))
    circleCell i jj =
      let j = jj // 2 in
        if shouldShow size i j then "*" else " "
  in
    List.map circleLine (List.range  1 size)

shouldShow size i j = shouldShowS size i j

shouldShowS s i j = abs (i^2 + j^2 - s^2) <= s+1

tableFromLines lines =
  let
    rows = List.map row lines
    row line = tr [] (List.map cell line)
    cell content = td cellStyle [text content]
  in
  table tableStyle rows

slider { makeMsg, minValue, maxValue, model } =
  div []
    [ text <| String.fromInt minValue
    , input
      [ type_ "range"
      , A.min <| String.fromInt minValue
      , A.max <| String.fromInt maxValue
      , value <| String.fromInt model
      , onInput (makeMsg << Maybe.withDefault 0 << String.toInt)
      ] []
    , text <| String.fromInt maxValue
    ]


{-- styling --}

tableStyle =
    [  style "border" "2px solid black"
    ]

cellStyle =
  [ style "border" "0px solid grey"
   , style "width" "10px"
   , style "height" "20px"
   , style "text-align" "center"
  ]
