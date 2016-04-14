module Leaflet.Geo.CRS.ESPG3395 (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, Transformation)
import Leaflet.Geometry.Transformation exposing (initTransformation)
import Leaflet.Geo.Earth as Earth
import Leaflet.Geo.CRS.CRS exposing (..)


projection : Projection
projection =
    Merkator.initProjection


transformation : Transformation
transformation =
    let
        scale = 0.5 / (pi * Merkator.r)
    in
        initTransformation ( scale, 0.5, -scale, 0.5 )


code : String
code =
    "EPSG3395"


initCrs : CRS
initCrs =
    CRS
        transformation
        projection
        scale
        zoom
        Earth.distance
        (latLngToPointFactory transformation projection scale)
        (pointToLatLngFactory transformation projection scale)
        (wrapLatLng infinity (Just Earth.wrapLatLng) Nothing)
        (getProjectedBounds infinity projection scale transformation.transform)
        infinity
        code
        Earth.distance
