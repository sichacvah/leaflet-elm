module Tests.Geo.CRS.EPSG3857 (..) where

import Leaflet.Geo.CRS.EPSG3857 exposing (initCrs)
import Leaflet.Geo.Models exposing (..)
import ElmTest exposing (..)
import Tests.Helpers exposing (..)


crs : CRS
crs =
    initCrs


latLngToPointSuite : Test
latLngToPointSuite =
    suite
        "#latLngToPoint"
        [ test "projects a center point" (assertNear (Just 1.0e-2) (crs.latLngToPoint <| LatLng 0.0 0.0 Nothing) (Point 128 128)) ]


all : Test
all =
    suite
        "Leaflet.Geo.CRS.ESPG3857"
        [ latLngToPointSuite ]
