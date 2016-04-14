module Leaflet.Map.View (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


pane : String -> Html
pane name =
    div [] []


container : Model -> Signal.Address Action -> Html
container model address =
    div
        [ class model.containerClass
        , style [ ( "position", "relative" ) ]
        ]
        (List.map (\className -> div [ class className ] []) model.panes)
