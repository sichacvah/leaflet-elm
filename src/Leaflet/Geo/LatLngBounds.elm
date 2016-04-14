module Leaflet.Geo.LatLngBounds (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geo.CRS.Earth as Earth
import Leaflet.Geo.LatLng as LatLng


pad : LatLngBounds -> Float -> LatLngBounds
pad bounds bufferRatio =
    let
        sw = bounds.sw

        ne = bounds.ne

        heightBuffer = (abs (sw.lat - ne.lat)) * bufferRatio

        withBuffer = (abs (sw.lng - ne.lng)) * bufferRatio
    in
        LatLngBounds
            (LatLng (sw.lat - heightBuffer) (sw.lng - withBuffer) Nothing)
            (LatLng (sw.lat + heightBuffer) (sw.lng + withBuffer) Nothing)


getCener : LatLngBounds -> LatLng
getCener bounds =
    let
        sw = bounds.sw

        ne = bounds.ne
    in
        LatLng ((sw.lat + ne.lat) / 2) ((sw.lng + ne.lng) / 2)


getNorth : LatLngBounds -> Float
getNorth bounds =
    bounds.ne.lat


getWest : LatLngBounds -> Float
getWest bounds =
    bounds.se.lng


getEast : LatLngBounds -> Float
getEast bounds =
    bounds.ne.lng


getSouth : LatLngBounds -> Float
getSouth bounds =
    bounds.se.lat


getNorthEast : LatLngBounds -> LatLng
getNorthEast bounds =
    bounds.ne


getSouthWest : LatLngBounds -> LatLng
getSouthWest bounds =
    bounds.sw


getNorthWest : LatLngBounds -> LatLng
getNorthWest bounds =
    LatLng (getNorth bounds) (getWest bounds) Nothing


getSouthEast : LatLngBounds -> LatLng
getSouthEast bounds =
    LatLng (getSouth bounds) (getEast bounds) Nothing


type GeoObj
    = BoundsObj LatLngBounds
    | LatLngObj LatLng


contains : LatLngBounds -> GeoObj -> Bool
contains bounds obj =
    let
        result sw ne =
            sw.lat
                >= bounds.sw.lat
                && ne.lat
                <= bounds.ne.lat
                && sw.lng
                >= bounds.sw.lng
                && ne.lng
                <= bounds.ne.lng
    in
        case obj of
            BoundsObj bounds' ->
                result bounds'.sw bounds'.ne

            LatLngObj latLng ->
                result latLng latLng


overlaps : LatLngBounds -> LatLngBounds -> Bool
overlaps bounds bounds' =
    let
        sw = bounds.sw

        ne = bounds.ne

        sw' = bounds'.sw

        ne' = bounds'.ne

        latOverlaps = (ne'.lat > sw.lat) && (sw'.lat < ne.lat)

        lngOverlaps = (ne'.lng > sw.lng) && (sw'.lng < ne.lng)
    in
        latOverlaps && lngOverlaps


equals : LatLngBounds -> LatLngBounds -> Bool
equals bounds bounds' =
    LatLng.equals (bounds.sw bounds'.sw) && LatLng.equals (bounds.ne bounds'.ne)
