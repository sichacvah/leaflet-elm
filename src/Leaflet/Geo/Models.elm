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


type alias ScaleFunc =
    Float -> Float


type alias ZoomFunc =
    Float -> Float


type alias DistanceFunc =
    LatLng -> LatLng -> Float


type alias PointToLatLng =
    Point -> Float -> LatLng


type alias WrapFunc =
    LatLng -> LatLng


type alias BoundsFunc =
    Float -> Maybe Bounds


type alias LatLngToPoint =
    LatLng -> Float -> Point


type alias CRS =
    { transformation : Transformation
    , projection : Projection
    , scale : ScaleFunc
    , zoom : ZoomFunc
    , distance : DistanceFunc
    , latLngToPoint : LatLngToPoint
    , pointToLatLng : PointToLatLng
    , wrapLatLng : WrapFunc
    , getProjectedBounds : BoundsFunc
    , infinity : Bool
    , code : String
    , distance : DistanceFunc
    }
