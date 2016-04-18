module Leaflet.Map.Models (..) where

import Leaflet.Geo.Models exposing (CRS, LatLng, LatLngBounds)
import Leaflet.CRS.EPSG3857 as ESPG3857


type alias Map =
  { crs : CRS
  , center : Maybe LatLng
  , zoom : Maybe Float
  , minZoom : Maybe Float
  , maxZoom : Maybe Float
  , maxBounds : Maybe LatLngBounds
  , fadeAnimation : Bool
  , markerZoomAnimation : Bool
  , transform3DLimit : Float
  , zoomSnap : Float
  , zoomDelta : Float
  , trackResize : Bool
  }



{- You can reinitialize default Map -}
defaultMap : Map
defaultMap =
  Map
    ESPG3857.initCrs
    Nothing
    Nothing
    Nothing
    Nothing
    Nothing
    True
    True
    8388608
    1
    1
    True

