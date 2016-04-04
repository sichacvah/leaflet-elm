module Leaflet.Geo.CRS.Update.Simple (..) where

import Leaflet.Geo.Models exposing (CRS, LatLng, Projection)
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


transform : Point -> Maybe Float -> Point
transform point scale =
    transformation.transform point scale


untransform : Point -> Maybe Float -> Point
untransform point scale =
    transformations.untransform point scale


scale : Float -> Float
scale zoom =
    2 ^ zoom


zoom : Float -> Float
zoom scale =
    logBase 2 scale


distance : LatLng -> LatLng -> Float
distance latLng1 latLng2 =
    let
        dx = latLng1.lng - latLng2.lng

        dy = latLng1.lat - latLng2.lat
    in
        sqrt (dx ^ 2 + dy ^ 2)
