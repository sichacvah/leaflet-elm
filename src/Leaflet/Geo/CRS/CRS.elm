module Leaflet.Geo.CRS.CRS (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geometry.Models exposing (Point, initBounds, Bounds, Transformation)
import Leaflet.Util exposing (wrapNum)
import Monocle.Iso exposing (Iso)
import Monocle.Lens exposing (Lens)


infinity : Bool
infinity =
    False


scaleIso : Iso Float Float
scaleIso =
    let
        get zoom = 256 * 2 ^ zoom

        reverseGet scale = logBase 2 (scale / 256)
    in
        Iso get reverseGet


projectIso : { projection : Projection } -> Iso LatLng Point
projectIso { projection } =
    Iso projection.project projection.unproject


transformIso : { transformation : Transformation } -> Iso ( Maybe Float, Point ) ( Maybe Float, Point )
transformIso { transformation } =
    let
        get ( scale, point ) = ( scale, transformation.transform point scale )

        reverseGet ( scale, point ) = ( scale, transformation.untransform point scale )
    in
        Iso get reverseGet


latLngToPointFactory : Transformation -> Projection -> ScaleFunc -> LatLngToPoint
latLngToPointFactory transformation projection scaleFunc latLng zoom =
    let
        scaled = Just (scaleFunc zoom)

        projectedPoint = projection.project latLng
    in
        transformation.transform projectedPoint scaled


pointToLatLngFactory : Transformation -> Projection -> ScaleFunc -> PointToLatLng
pointToLatLngFactory transformation projection scaleFunc point zoom =
    let
        scaled = Just (scaleFunc zoom)

        untransformedPoint = transformation.untransform point scaled
    in
        projection.unproject untransformedPoint


getProjectedBounds : Bool -> Projection -> ScleFunc -> (Point -> Maybe Float -> Point) -> BoundsFunc
getProjectedBounds infinity projection scaleFunc transform zoom =
    if crs.inifinity then
        Nothing
    else
        let
            b = projection.bounds

            s = scaleFunc zoom

            min = transform b.min s

            max = transform b.max s
        in
            initBounds min max


wrapLatLng : Maybe ( Float, Float ) -> Maybe ( Float, Float ) -> WrapFunc
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
