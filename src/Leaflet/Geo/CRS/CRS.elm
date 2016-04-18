module Leaflet.Geo.CRS.CRS (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geometry.Models exposing (Point, initBounds, Bounds, Transformation)
import Leaflet.Util exposing (wrapNum)
import Monocle.Iso exposing (Iso)
import Monocle.Lens exposing (Lens)


type alias WrapCoord =
    Maybe ( Float, Float )


crsConstructor : Projection -> Transformation -> Iso Float Float -> WrapCoord -> WrapCoord -> Bool -> String ->  CRS
crsConstructor projection transformation scaleIso wrapLat wrapLng infinity code =
  CRS
    (latLngToPointFactory transformation projection scaleIso.get)
    (pointToLatLngFactory transformation projection scaleIso.get)
    (getProjectedBounds infinity projection scaleIso.get transformation)
    (wrapLatLng wrapLat wrapLng)
    projection
    transformation
    (Debug.log "infinity" infinity)
    code


scaleIso : Iso Float Float
scaleIso =
    let
        get = (\zoom -> 256 * 2 ^ zoom)

        reverseGet = (\scale -> logBase 2 (scale / 256))
    in
        Iso get reverseGet


latLngToPointFactory : Transformation -> Projection -> (Float -> Float) -> LatLng -> Float -> Point
latLngToPointFactory transformation projection scaleFunc latLng zoom =
    let
        scaled = Just (scaleFunc zoom)

        projectedPoint = projection.project latLng
    in
        transformation.transform projectedPoint scaled


pointToLatLngFactory : Transformation -> Projection -> (Float -> Float) -> Point -> Float -> LatLng
pointToLatLngFactory transformation projection scaleFunc point zoom =
    let
        scaled = Just (scaleFunc zoom)

        untransformedPoint = transformation.untransform point scaled
    in
        projection.uproject untransformedPoint


getProjectedBounds : Bool -> Projection -> (Float -> Float) -> Transformation -> Float -> (Maybe Bounds)
getProjectedBounds infinity projection scaleFunc transformation zoom =
    if infinity then
        Nothing
    else
        let
            b = projection.bounds

            s = scaleFunc zoom

            min = transformation.transform b.min  (Just s)

            max = transformation.transform b.max  (Just s)
        in

            Just (initBounds min max)


wrapLatLng : Maybe ( Float, Float ) -> Maybe ( Float, Float ) -> LatLng -> LatLng
wrapLatLng wrapLng wrapLat latLng =
    let
        wrapIfNeed maybeWrap x =
            case maybeWrap of
                Nothing ->
                    x

                Just tuple ->
                    wrapNum x tuple True

        lng = wrapIfNeed wrapLng latLng.lng

        lat = wrapIfNeed wrapLat latLng.lat

        alt = latLng.alt
    in
        LatLng lat lng alt
