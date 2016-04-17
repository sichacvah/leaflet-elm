module Leaflet.Geo.Models (..) where

import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, TransformFuncType, Transformation)


type alias LatLng =
    { lat : Float
    , lng : Float
    , alt : Maybe Float
    }


type alias LatLngBounds =
    { sw : LatLng
    , ne : LatLng
    }


type alias Projection =
    { project : LatLng -> Point
    , uproject : Point -> LatLng
    , bounds : Bounds
    }


type alias CRS =
    { latLngToPoint : Float -> LatLng -> Point
    , pointToLatLng : Float -> Point -> LatLng
    , getProjectedBounds : Float -> LatLngBounds
    , wrapLatLng : LatLng -> LatLng
    , projection : Projection
    , transformation : Transformation
    , infinity : Bool
    , code : String
    }
