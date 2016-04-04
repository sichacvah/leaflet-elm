module Leaflet.Geo.Projection.Merkator (..) where

import Leaflet.Geometry.Models exposing (LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point, initBounds)


r : Float
r =
    6378137


d : Float
d =
    pi / 180


rMinor : Float
rMinor =
    6356752.314245179


tmp : Float
tmp =
    rMinor / r


e : Float
e =
    sqrt (1 - tmp ^ 2)


bounds : Bounds
bounds =
    let
        min = Point (negate 2.003750834279e7) (negate 1.549657073972e7)

        max = Point 2.003750834279e7 1.876465623138e7
    in
        initBounds min max


project : LatLng -> Point
porject latLng =
    let
        y = latLng.lat * d

        tmp = rMinor / r

        con = e * sin <| y

        ts = (tan <| pi / 4 - y / 2) / ((1 - con) / (1 + con) ^ (e / 2))

        yCoord = (negate r) * log <| max ts 1.0e-10

        xCoord = latLng.lng * d * r
    in
        Point xCoord yCoord


updatePhi : Float -> Int -> Float -> Float
updatePhi phi i dphi =
    if i < 15 && (abs dphi) < 1.0e-7 then
        let
            con = ((1 - e * (sin phi)) / (1 + e * (sin phi))) ^ (e / 2)
        in
            (updatePhi phi (i + 1))
                <| phi
                + (pi / 2 - 2 * (atan <| ts * con) - phi)
    else
        dphi


unproject : Point -> LatLng
unproject point =
    let
        ts = exp <| (negate point.y) / r

        phi = pi / 2 - 2 * (atan ts)
    in
        LatLng ((updatePhi phi 0 phi) * d) (point.x * d / r) Nothing


initProjection : Projection
initProjection =
    Projection project unproject bounds
