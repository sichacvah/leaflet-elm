module Leaflet.Geo.Projection.LonLat (..) where

import Leaflet.Geo.Models exposing (LatLng, Projection)
import Leaflet.Geometry.Models exposing (Point, initBounds, Bounds)


project : LatLng -> Point
project latLng =
    Point latLng.lng latLng.lat


unproject : Point -> LatLng
unproject point =
    LatLng point.y point.x Nothing


bounds : Bounds
bounds =
    let
        min = Point -180 -90

        max = Point 180 90
    in
        initBounds min max
