module Leaflet.Geo.Projection.SphericalMerkator (..) where

import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds)
import Leaflet.Geo.Models exposing (LatLng, Projection)


r : Float
r =
    6378137


maxLatitude : Float
maxLatitude =
    85.0511287798


project : LatLng -> Point
project latLng =
    let
        d = pi / 180

        max' = maxLatitude

        lat = max (min max' latLng.lat) (negate max')

        sinLat = sin <| lat * d
    in
        Point (r * latLng.lng * d) (r * logBase e ((1 + sinLat) / (1 - sinLat)) / 2)


unproject : Point -> LatLng
unproject point =
    let
        d = 180 / pi
    in
        LatLng
            ((2 * (atan (e ^ (point.y / r))) - pi / 2) * d)
            (point.x * d / r)
            Nothing


bounds : Bounds
bounds =
    let
        d = 6378137 * pi

        min = Point -d -d

        max = Point d d
    in
        initBounds min max


initProjection : Projection
initProjection =
    Projection project unproject bounds
