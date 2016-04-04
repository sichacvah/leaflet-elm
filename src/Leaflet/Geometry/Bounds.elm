module Leaflet.Geometry.Bounds (..) where

import Leaflet.Geometry.Models exposing (Point, Bounds, initPoint)
import Leaflet.Geometry.Point exposing (substract)


type GeoObj
    = PointProc Point
    | BoundsProc Bounds


getCenter : Bool -> Bounds -> Point
getCenter round bounds =
    let
        max = bounds.max

        min = bounds.min

        x = (max.x + min.x) / 2

        y = (max.y + min.y) / 2
    in
        initPoint round x y


getBottomLeft : Bounds -> Point
getBottomLeft bounds =
    Point bounds.min.x bounds.min.y


getTopRight : Bounds -> Point
getTopRight bounds =
    Point bounds.max.x bounds.min.y


getSize : Bounds -> Point
getSize bounds =
    substract bounds.max bounds.min


contains : Bounds -> GeoObj -> Bool
contains bounds geoObj =
    let
        result max min =
            min.x
                >= bounds.min.x
                && max.x
                <= bounds.max.x
                && min.y
                >= bounds.min.y
                && max.y
                <= bounds.max.y
    in
        case geoObj of
            PointProc point ->
                result point point

            BoundsProc b ->
                result b.max b.min


intersects : Bounds -> Bounds -> Bool
intersects bounds1 bounds2 =
    let
        min1 = bounds1.min

        min2 = bounds2.min

        max1 = buunds1.max

        max2 = bounds2.max

        xIntersects = max2.x >= min1.x && min2.x <= max1.x

        yIntersects = max2.y >= min1.y && min2.y <= max1.y
    in
        xIntersects && yIntersects


overlaps : Bounds -> Bounds -> Bool
overlaps bounds1 bounds2 =
    let
        min1 = bounds1.min

        min2 = bounds2.min

        max1 = bounds1.max

        max2 = bounds2.max

        xOverlaps = max2.x > min1.x && min2.x < max1.x

        yOverlaps = max2.y > min1.y && min2.y < max1.y
    in
        xOverlaps && yOverlaps
