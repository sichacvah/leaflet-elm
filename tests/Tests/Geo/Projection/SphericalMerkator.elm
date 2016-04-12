module Tests.Geo.Projection.SphericalMerkator (..) where

import Leaflet.Geo.Projection.SphericalMerkator exposing (..)
import Leaflet.Geo.Models exposing (LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point)
import ElmTest exposing (..)
import Tests.Helpers exposing (..)


p : Projection
p =
    initProjection


projectSuite : Test
projectSuite =
    let
        near = assertNear Nothing
    in
        suite
            "#project"
            [ test "projects a center point" (near (p.project <| LatLng 0.0 0.0 Nothing) (Point 0.0 0.0))
            , test "projects the northeast corner of the world" (near (p.project <| LatLng 85.0511287798 180 Nothing) (Point 20037508 20037508))
            , test "projects the southwest corner of the world" (near (p.project <| LatLng -85.0511287798 -180 Nothing) (Point -20037508 -20037508))
            , test "projects other points" (near (p.project <| LatLng 51.9371170300465 80.11230468750001 Nothing) (Point 8918060.96409 6788763.38325))
            ]


unProjectSuite : Test
unProjectSuite =
    let
        near = assertNear Nothing

        pr point = p.project (p.uproject point)
    in
        suite
            "#unproject"
            [ test "unprojects a center point" (near (pr <| Point 0.0 0.0) (Point 0.0 0.0))
            , test "unprojects pi points" (near (pr <| Point (negate pi) pi) (Point (negate pi) pi))
            , test "unprojects pi points" (near (pr <| Point (negate pi) (negate pi)) (Point (negate pi) (negate pi)))
            , test "unprojects other point" (near (pr <| Point 0.523598775598 1.010683188683) (Point 0.523598775598 1.010683188683))
            , test "unprojects other point" (near (pr <| Point 8918060.964088084 6755099.410887127) (Point 8918060.964088084 6755099.410887127))
            ]


all : Test
all =
    suite
        "Leaflet.Geo.Projection.SphericalMerkator"
        [ projectSuite
        , unProjectSuite
        ]
