module Leaflet.Map.Actions (..) where

import Http
import Leaflet.Map.Models exposing (Options)
import Leaflet.Utils exposing (LatLng, Zoom, Delta)


type alias EventName = String


type Action = 
  NoOp
  | FireEvent EventName
