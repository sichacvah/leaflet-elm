module Leaflet.Geo.CRS.Update (..) where

import Leaflet.Geo.CRS.CRSType as CRSType
import Leaflet.Geo.CRS.Update.CRS as CRS
import Leaflet.Geo.CRS.Update.Earth as Earth
import Leaflet.Geo.CRS.Update.Simple as Simple
import Leaflet.Geo.CRS.Update.EPSG3395 as EPSG3395
import Leaflet.Geo.CRS.Update.EPSG3857 as EPSG3857
import Leaflet.Geo.CRS.Update.EPSG4326 as EPSG4326


scale : CRSType -> Float -> Float
scale action =
    case action of
        CRSType.Simple ->
            Simple.scale

        _ ->
            CRS.scale


zoom : CRSType.CRSType -> Float -> Float
zoom actiom =
    case action of
        CRSType.Simple ->
            Simple.zoom

        _ ->
            CRS.zoom


distance : CRSType.CRSType -> LatLng -> LatLng -> Float
distance action =
    case action of
        CRSType.Simple ->
            Simple.distance

        _ ->
            Earth.distance


latLngToPoint : CRSType.CRSType -> Transformation -> Projection -> (Float -> Float) -> LatLng -> Maybe Float -> Point
latLngToPoint action =
    case action of
        _ ->
            CRS.latLngToPoint (transformation action) (projection action) (scale action)


projection : CRSType.CRSType -> Projection
projection action =
    case action of
        CRSType.ESPG4326 ->
            ESPG4326.projection

        CRSType.ESPG3395 ->
            ESPG3395.projection

        CRSType.ESPG3857 ->
            ESPG3857.projection

        CRSType.Simple ->
            Simple.projection


transformation : CRSType.CRSType -> Transformation
transformation action =
    case action of
        CRSType.ESPG4326 ->
            ESPG4326.transformation

        CRSType.ESPG3395 ->
            ESPG3395.transformation

        CRSType.ESPG3857 ->
            ESPG3857.transformation

        CRSType.Simple ->
            Simple.transformation
