module Leaflet.Geo.CRS.Earth (..) where

import Leaflet.Geo.Models exposing (..)
import Leaflet.Geo.CRS.CRS as Crs


wrapLng : ( Float, Float )
wrapLng =
    ( -180, 180 )


infinity : Bool
infinity =
    Crs.infinity


r : Float
r =
    6371000


distance : LatLng -> LatLng -> Float
distance latLng1 latLng2 =
    let
        rad = pi / 180

        lat1 = latLng1.lat * r

        lat2 = latLng2.lat * r

        a = (sin lat1) * (sin lat2) + (cos lat1) * (cos * lat2) * (cos <| (latLng2.lng - latLng1.lng) * rad)
    in
        r * acos (min a 1)


wrapLatLng : LatLng -> LatLng
wrapLatLng =
    Crs.wrapLatLng wrapLatLng Nothing