module Tests.Geo.CRS.EPSG3857 (..) where

import Leaflet.Geo.CRS.EPSG3857 exposing (initCrs)
import Leaflet.Geo.Models exposing (LatLng, CRS)
import Leaflet.Geometry.Models exposing (Point)
import Leaflet.Geometry.Bounds exposing (getSize)
import ElmTest exposing (..)
import Tests.Helpers exposing (..)


crs : CRS
crs =
    initCrs


latLngToPointSuite : Test
latLngToPointSuite =
    suite
        "#latLngToPoint"
        [ test "projects a center point" (assertNear (Just 1.0e-2) (crs.latLngToPoint (LatLng 0.0 0.0 Nothing) 0.0) (Point 128 128)) 
        , test "projects the northeast corner the world" (assertNear Nothing (crs.latLngToPoint (LatLng 85.0511287798 180 Nothing) 0) (Point 256 0))
        ]


pointToLatLngSuite : Test
pointToLatLngSuite =
    suite
        "#pointToLatLng"
        [ test "reprojects a center point" (assertNearLatLng (Just 0.01) (crs.pointToLatLng (Point 128.0 128.0) 0.0) (LatLng 0.0 0.0 Nothing))
        , test "reprojects the northeast corner of the world" (assertNearLatLng Nothing (crs.pointToLatLng (Point 256.0 0.0) 0.0) (LatLng 85.0511287798 180 Nothing))
        ]


projectSuite : Test
projectSuite =
  suite
    "#project"
    [ test "projects geo coords into meter coords correctly" (assertNear Nothing (crs.projection.project (LatLng 50.0 30.0 Nothing)) (Point 3339584.7238 6446275.84102))
    , test "projects geo coords into meter coords correctly" (assertNear Nothing (crs.projection.project (LatLng 85.0511287798 180.0 Nothing)) (Point 20037508.34279 20037508.34278))
    , test "projects geo coords into meter coords correctly" (assertNear Nothing (crs.projection.project (LatLng -85.0511287798 -180.0 Nothing)) (Point -20037508.34279 -20037508.34278))
    ]


unProjectSuite : Test
unProjectSuite =
  suite
    "#unproject"
    [ test "unprojects meter coords into geo coords correctly" (assertNearLatLng Nothing (crs.projection.uproject (Point 3339584.7238 6446275.84102)) (LatLng 50 30 Nothing)) 
    , test "unprojects meter coords into geo coords correctly" (assertNearLatLng Nothing (crs.projection.uproject (Point 20037508.34279 20037508.34279)) (LatLng 85.0511287798 180.0 Nothing)) 
    , test "unprojects meter coords into geo coords correctly" (assertNearLatLng Nothing (crs.projection.uproject (Point -20037508.34279 -20037508.34279)) (LatLng -85.0511287798 -180 Nothing)) 
    ]



getProjectedBoundsSuite : Test
getProjectedBoundsSuite =
  let  
      worldSize i = 256 * (2 ^ i)
      getTest i = 
        test "gives correct size" (assertBounds (crs.getProjectedBounds i) (worldSize i))
  in
    suite
      "#getProjectedBounds"
      (List.map getTest [0..22])



wrapLatLngSuite : Test
wrapLatLngSuite =
  suite
    "#wrapLatLng"
      [ test "wraps longitude to lie between -180 and 180 by default" (assertEqual (crs.wrapLatLng (LatLng 0.0 190.0 Nothing)).lng -170)
      , test "wraps longitude to lie between -180 and 180 by default" (assertEqual (crs.wrapLatLng (LatLng 0.0 360.0 Nothing)).lng 0)
      , test "wraps longitude to lie between -180 and 180 by default" (assertEqual (crs.wrapLatLng (LatLng 0.0 380.0 Nothing)).lng 20)
      , test "wraps longitude to lie between -180 and 180 by default" (assertEqual (crs.wrapLatLng (LatLng 0.0 -190.0 Nothing)).lng 170)
      , test "wraps longitude to lie between -180 and 180 by default" (assertEqual (crs.wrapLatLng (LatLng 0.0 -360.0 Nothing)).lng 0)
      , test "wraps longitude to lie between -180 and 180 by default" (assertEqual (crs.wrapLatLng (LatLng 0.0 -380.0 Nothing)).lng -20)
      , test "wraps longitude to lie between -180 and 180 by default" (assertEqual (crs.wrapLatLng (LatLng 0.0 90.0 Nothing)).lng 90)
      , test "wraps longitude to lie between -180 and 180 by default" (assertEqual (crs.wrapLatLng (LatLng 0.0 180.0 Nothing)).lng 180)
      , test "does not drop altitude" (assertEqual (crs.wrapLatLng (LatLng 0.0 190.0 (Just 1234))).lng -170)
      , test "does not drop altitude" (assertEqual (crs.wrapLatLng (LatLng 0.0 190.0 (Just 1234))).alt (Just 1234))
      , test "does not drop altitude" (assertEqual (crs.wrapLatLng (LatLng 0.0 380.0 (Just 1234))).lng 20)
      , test "does not drop altitude" (assertEqual (crs.wrapLatLng (LatLng 0.0 380.0 (Just 1234))).alt (Just 1234))
      ]


all : Test
all =
    suite
        "Leaflet.Geo.CRS.ESPG3857"
        [ latLngToPointSuite, pointToLatLngSuite, projectSuite, unProjectSuite, getProjectedBoundsSuite, wrapLatLngSuite ]
