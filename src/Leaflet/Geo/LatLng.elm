module Leaflet.Geo.LatLng (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geo.CRS.Earth as Earth


defaultMaxMargin : Maybe Float -> Float
defaultMaxMargin maybeMargin =
    Maybe.withDefault 1.0e-9 maybeMargin


equals : Maybe Float -> LatLng -> LatLng -> Bool
equals maxMargin latLng1 latLng2 =
    let
        margin =
            max
                (abs (latLng1.lat - latLng2.lat))
                (abs (latLng1.lng - latLng2.lng))
    in
        margin <= (defaultMaxMargin maxMargin)


distanceTo : LatLng -> LatLng -> Float
distanceTo latLng1 latLng2 =
    Earth.distance latLng1 latLng2


wrap : LatLng -> LatLng
wrap latLng =
    Earth.wrapLatLng latLng


toBounds : LatLng -> Float -> LatLngBounds
toBounds latLng sizeInMeters =
    let
        latAccuracy = 180 * sizeInMeters / 40075017

        lngAccuracy = latAccuracy / (cos (pi / 180 * latLng.lat))
    in
        LatLngBounds
            (LatLng (latLng.lat - latAccuracy) (latLng.lng - lngAccuracy) Nothing)
            (LatLng (latLng.lat + latAccuracy) (latLng.lng + lngAccuracy) Nothing)
