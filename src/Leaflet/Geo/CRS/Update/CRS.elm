module Leaflet.Geo.CRS.Update.CRS (..) where

import Leaflet.Geo.Models exposing (LatLng, CRS)
import Leaflet.Geometry.Models exposing (Point, initBounds, Bounds, Transformation)
import Leaflet.Util exposing (wrapNum)


scale : Float -> Float
scale zoom =
    256 * (2 ^ zoom)


zoom : Float -> Float
zoom =
    logBase 2 (scale / 256)


latLngToPoint : Transformation -> Projection -> (Float -> Float) -> LatLng -> Maybe Float -> Point
latLngToPoint transformation projection scale latLng zoom =
    let
        scaled = Just (scale zoom)

        projectedPoint = projection.project latLng
    in
        transformation.transform projectedPoint scaled


pointToLatLng : Transformation -> Projection -> (Float -> Float) -> Point -> Maybe Float -> Point
pointToLatLng transformation projection scale point zoom =
    let
        scaled = Just (scale zoom)

        untransformedPoint = transformation.untransform point scaled
    in
        projection.unproject untransformedPoint


project : Projection -> LatLng -> Point
project projection latLng =
    projection.project latLng


unproject : Projection -> Point -> LatLng
unproject projection point =
    projection.unproject point


getProjectedBounds : Bool -> Projection -> (Float -> Float) -> (Point -> Maybe Float -> Point) -> Float -> Maybe Bounds
getProjectedBounds infinity projection scale transform zoom =
    if crs.inifinity then
        Nothing
    else
        let
            b = projection.bounds

            s = scale zoom

            min = transform b.min s

            max = transform b.max s
        in
            initBounds min max


wrapLatLng : Maybe ( Float, Float ) -> Maybe ( Float, Float ) -> LatLng -> LatLng
wrapLatLng wrapLng wrapLat latLng =
    let
        wrapIfNeed maybeWrap x =
            case maybeWrap of
                Nothing ->
                    x

                Just tuple ->
                    wrapNum x tuple True

        lng = wrapNeed wrapLng latLng.lng

        lat = wrapIfNeed wrapLat latLng.lat

        alt = latLng.alt
    in
        LatLng lat lng alt
