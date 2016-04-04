module Leaflet.Geo.CRS.Update.ESPG4326 (..) where

import Leaflet.Geo.Models exposing (CRS, LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, Transformation)
import Leaflet.Geometry.Transformation exposing (initTransformation)
import Leaflet.Geo.Projection.LonLat as LonLat
import Leaflet.Geo.CRS.Earth as Earth


projection : Projection
projection =
    LonLat.initProjection


transformation : Transformation
transformation =
    initTransformation ( 1 / 180, 1, -1 / 180, 0.5 )
