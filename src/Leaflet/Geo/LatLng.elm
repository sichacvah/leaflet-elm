module Leaflet.Geo.LatLng (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geo.CRS.Earth exposing (distance)


defaultMaxMargin : Maybe Float -> Float
defaultMaxMargin maybeMargin =
    Maybe.withDefault 1.0e-9 maybeMargin


equals : Maybe Float -> LatLng -> LatLng -> Bool
equals maxMargin latLng1 latLng2 =
    let
        margin =
            max
                (abs <| latLng1.lat - latLng2.lat)
                (abs <| latLng1.lng - latLng2.lng)
    in
        margin <= (defaultMaxMargin maxMargin)


distanceTo : LatLng -> LatLng -> Float
distanceTo latLng1 latLng2 =
    distance latLng1 latLng2
