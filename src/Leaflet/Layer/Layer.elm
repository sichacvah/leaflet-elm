module Leaflet.Layer.Layer (..) where

import Effects exposing (Effects)
import Leaflet.Layer.Models exposing (Model)
import Leaflet.Layer.Actions exposing (Action)
import Html exposing (Html)

type alias Layer =
  Layer
  { view : Signal.Address Action -> Layer -> Html
  , update : Action -> Layer -> ( Layer, Effects Action )
  , model : Model
  }
