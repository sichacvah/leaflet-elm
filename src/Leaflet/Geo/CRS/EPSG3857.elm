module Leaflet.Geo.CRS.EPSG3857 (..) where

import Leaflet.Geo.Models exposing (CRS, LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, Transformation)
import Leaflet.Geometry.Transformation exposing (initTransformation)
import Leaflet.Geo.Projection.SphericalMerkator as SphericalMerkator
import Leaflet.Geo.CRS.CRS exposing (scaleIso)
import Leaflet.Geo.CRS.Earth exposing (earthConstructor)


projection : Projection
projection =
    SphericalMerkator.initProjection


transformation : Transformation
transformation =
    let
        scale = 0.5 / (pi * SphericalMerkator.r)
    in
        initTransformation ( scale, 0.5, -scale, 0.5 )


code : String
code =
    "ESPG3857"


initCrs : CRS
initCrs =
    earthConstructor
        projection
        transformation
        scaleIso
        code
