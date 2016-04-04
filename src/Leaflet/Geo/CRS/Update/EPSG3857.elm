module Leaflet.Geo.CRS.Update.ESPG3857 (..) where

import Leaflet.Geo.Models exposing (CRS, LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, Transformation)
import Leaflet.Geometry.Transformation exposing (initTransformation)
import Leaflet.Geo.Projection.SphericalMerkator as SphericalMerkator
import Leaflet.Geo.CRS.CRS as Crs
import Leaflet.Geo.CRS.Earth as Earth


projection : Projection
projection =
    SphericalMerkator.initProjection


transformation : Transformation
transformation =
    let
        scale = 0.5 / (pi * SphericalMerkator.r)
    in
        initTransformation ( scale, 0.5, -scale, 0.5 )
