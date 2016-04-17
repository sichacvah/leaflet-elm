module Leaflet.Geo.CRS.ESPG4326 (..) where

import Leaflet.Geo.Models exposing (CRS, LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds, Transformation)
import Leaflet.Geometry.Transformation exposing (initTransformation)
import Leaflet.Geo.Projection.LonLat as LonLat
import Leaflet.Geo.CRS.CRS exposing (scaleIso)
import Leaflet.Geo.CRS.Earth exposing (earthConstructor)


projection : Projection
projection =
    LonLat.initProjection


transformation : Transformation
transformation =
    initTransformation ( 1 / 180, 1, -1 / 180, 0.5 )


code : String
code =
    "ESPG4326"


initCrs : CRS
initCrs =
    earthConstructor
        projection
        transformation
        scaleIso
        code
