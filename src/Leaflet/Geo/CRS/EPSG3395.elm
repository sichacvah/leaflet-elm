module Leaflet.Geo.CRS.ESPG3395 (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, Transformation)
import Leaflet.Geometry.Transformation exposing (initTransformation)
import Leaflet.Geo.Geo exposing (scaleIso)
import Leaflet.Geo.Earth exposing (..)


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
    earthConstructor
        projection
        transformation
        scaleIso
        code
