module Leaflet.Map.Actions (..) where

import Http
import Leaflet.Map.Models exposing (Options)
import Leaflet.Utils exposing (LatLng, Zoom, Delta)


type Action
    = NoOp
    | SetView LatLng Zoom
    | SetZoom Zoom
    | ZoomIn Delta
    | ZoomOut Delta
