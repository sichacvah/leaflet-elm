module Leaflet.Geo.Projection.Merkator (..) where

import Leaflet.Geo.Models exposing (LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds)


r : Float
r =
    6378137


rMinor : Float
rMinor =
    6356752.314245179


tmp : Float
tmp =
    rMinor / r


es : Float
es =
    sqrt (1 - tmp * tmp)


bounds : Bounds
bounds =
    let
        min = Point (negate 2.003750834279e7) (negate 1.549657073972e7)

        max = Point 2.003750834279e7 1.876465623138e7
    in
        initBounds min max


project : LatLng -> Point
project latLng =
    let
        d = pi / 180

        y = latLng.lat * d

        tmp = rMinor / r

        con = es * (sin y)

        ts = (tan (pi / 4 - y / 2)) / (((1 - con) / (1 + con)) ^ (es / 2))

        yCoord = (negate r) * (logBase e (max ts 1.0e-10))

        xCoord = latLng.lng * d * r
    in
        Point xCoord yCoord


updatePhi : Float -> Float -> Int -> Float -> Float
updatePhi ts phi i dphi =
    if i < 15 && (abs dphi) > 1.0e-7 then
        let
            con' = es * (sin phi)

            con = ((1 - con') / (1 + con')) ^ (es / 2)

            dphi' = pi / 2 - 2 * (atan (ts * con)) - phi

            phi' = phi + dphi'
        in
            updatePhi ts phi' (i + 1) dphi'
    else
        phi


unproject : Point -> LatLng
unproject point =
    let
        d = 180 / pi

        ts = e ^ ((0 - point.y) / r)

        phi = pi / 2 - 2 * (atan ts)
    in
        LatLng ((updatePhi ts phi 0 0.1) * d) (point.x * d / r) Nothing


initProjection : Projection
initProjection =
    Projection project unproject bounds
