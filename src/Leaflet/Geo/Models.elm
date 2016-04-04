module Leaflet.Geo.Models (..) where

import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, TransformFuncType)
import Leaflet.Geo.Update exposing (..)


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
    { transformation : Transformation
    , projection : Projection
    , scale : Float -> Float
    , zoom : Float -> Float
    , distance : LatLng -> LatLng -> Float
    , latLngToPoint : LatLng -> Float -> Point
    , pointToLatLng : Point -> Float -> LatLng
    , wrapLatLng : LatLng -> LatLng
    , getProjectedBounds : Float -> Maybe Bounds
    }


initCrs : CRSType -> CRS
initCrs crsType =
    CRS
        transformation
        crsType
        projection
        crsType
        scale
        crsType
        zoom
        crsType
        distance
        crsType
        latLngToPoint
        crsType
        pointToLatLng
        crsType
        wrapLatLng
        crsType
        pointToLatLng
        crsType
        wrapLatLng
        crsType
        getProjectedBounds
        crsType
