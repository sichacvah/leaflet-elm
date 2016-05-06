module Leaflet.Layer.Models (..) where

import Leaflet.Layer.Action exposing (..)
import Leaflet.Geo.Models exposing (LatLng)


type alias Model =
  { latLng : LatLng
  , pane : Pane
  }


type Pane
  = Overlay
  | Map
  | Tile
  | Objects
  | Shadow
  | Marker
  | Popup
