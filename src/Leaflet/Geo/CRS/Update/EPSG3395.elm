module Leaflet.Geo.CRS.Update.ESPG3395 (..) where

import Leaflet.Geo.Models exposing (CRS, LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, Transformation)
import Leaflet.Geometry.Transformation exposing (initTransformation)


projection : Projection
projection =
    Merkator.initProjection


transformation : Transformation
transformation =
    let
        scale = 0.5 / (pi * Merktor.r)
    in
        initTransformation ( scale, 0.5, -scale, 0.5 )
