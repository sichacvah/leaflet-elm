module Leaflet.Geo.CRS.CRS (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geometry.Models exposing (Point, initBounds, Bounds, Transformation)
import Leaflet.Util exposing (wrapNum)
import Monocle.Iso exposing (Iso)
import Monocle.Lens exposing (Lens)


type CRSBase =
  CRSBase
  { latLngToPoint : Zoom -> LatLng -> Point
  , pointToLatLng : Zoom -> Point -> LatLng
  , getProjectedBounds : Float -> LatLngBounds
  , wrapLatLng : LatLng -> LatLng
  , infinity : Bool
  }



crsConstructor : Projection -> Transformation -> ( Iso Float Float ) -> Bool -> CRSBase
crsConstructor projection transformation scaleIso  infinity =
  CRSBase
  { latLngToPoint = (latLngToPointFactory transformation projection scaleIso.get)
  , pointToLatLng = (pointToLatLngFactory transformation projection scaleIso.get)
  , getProjectedBounds = (getProjectedBounds infinity projection scaleIso.get)
  , wrapLatLng = 
  }



infinity : Bool
infinity =
    False

scaleIso : Iso Float Float
scaleIso =
  let 
      get = (\zoom -> 256 * 2 ^ zoom)

      reverseGet = (\scale -> logBase 2 (scalse / 256))

  in
      Iso get reverseGet


latLngToPointFactory : Transformation -> Projection -> (Float -> Float) -> LatLngToPoint
latLngToPointFactory transformation projection scaleFunc latLng zoom =
    let
        scaled = Just (scaleFunc zoom)

        projectedPoint = projection.project latLng
    in
        transformation.transform projectedPoint scaled


pointToLatLngFactory : Transformation -> Projection -> (Float -> Float) -> PointToLatLng
pointToLatLngFactory transformation projection scaleFunc point zoom =
    let
        scaled = Just (scaleFunc zoom)

        untransformedPoint = transformation.untransform point scaled
    in
        projection.unproject untransformedPoint


getProjectedBounds : Bool -> Projection -> (Float -> Float) -> (Point -> Maybe Float -> Point) -> BoundsFunc
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


