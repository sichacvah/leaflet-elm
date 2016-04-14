module Leaflet.Geo.CRS.Simple (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, Transformation)
import Leaflet.Geometry.Transformation exposing (initTransformation)
import Leaflet.Geo.Projection.LonLat as LonLat
import Leaflet.Geo.CRS.CRS as Crs


projection : Projection
projection =
    LonLat.initProjection


transformation : Transformation
transformation =
    initTransformation ( 1, 0, (negate 1), 0 )


scale : ScaleFunc
scale zoom =
    2 ^ zoom


zoom : ScaleFunc
zoom scale =
    logBase 2 scale


distance : DistanceFunc
distance latLng1 latLng2 =
    let
        dx = latLng1.lng - latLng2.lng

        dy = latLng1.lat - latLng2.lat
    in
        sqrt (dx ^ 2 + dy ^ 2)


infinity : Bool
infinity =
    True


code : String
code =
    "Simple"


initCrs : CRS
initCrs =
    CRS
        transformation
        projection
        scale
        zoom
        distance
        (Crs.latLngToPointFactory transformation projection scale)
        (Crs.pointToLatLngFactory transformation projection scale)
        (Crs.wrapLatLng infinity Nothing Nothing)
        (Crs.getProjectedBounds inifinity projection transformation.transform)
        infinity
        code
        distance
