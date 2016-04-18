module Leaflet.Layer.Models (..) where

type alias Layer = 
  { pane : Pane
  }


type Pane
  = Overlay
  | Map
  | Tile
  | Objects
  | Shadow
  | Marker
  | Popup
