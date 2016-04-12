module Tests.Geo.Projection.Merkator (..) where

import Leaflet.Geo.Projection.Merkator exposing (..)
import Leaflet.Geo.Models exposing (LatLng, Projection)
import Leaflet.Geometry.Models exposing (Bounds, Point)
import ElmTest exposing (..)
import Tests.Helpers exposing (..)


p : Projection
p =
    initProjection


projectSuite : Test
projectSuite =
    suite
        "#project"
        [ test "projects a center point" (assertNear Nothing (p.project <| LatLng 0.0 0.0 Nothing) (Point 0.0 0.0))
        , test "projects the northeast corner of the world" (assertNear Nothing (p.project <| LatLng 85.0840591556 180 Nothing) (Point 20037508 20037508))
        , test "projects the southwest corner of the world" (assertNear Nothing (p.project <| LatLng (negate 85.0840591556) (negate 180) Nothing) (Point (negate 20037508) (negate 20037508)))
        , test "projects other points" (assertNear Nothing (p.project <| LatLng 50 30 Nothing) (Point 3339584 6413524))
        , test "projects other points " (assertNear Nothing (p.project <| LatLng 51.9371170300465 80.11230468750001 Nothing) (Point 8918060.964088084 6755099.410887127))
        ]


unProjectSuite : Test
unProjectSuite =
    let
        near = assertNear Nothing

        pr point =
            p.project (p.uproject point)
    in
        suite
            "#project"
            [ test "unprojects a center point" (near (pr <| Point 0.0 0.0) (Point 0.0 0.0))
            , test "unprojects pi points" (near (pr <| Point (negate pi) pi) (Point (negate pi) pi))
            , test "unprojects pi points" (near (pr <| Point (negate pi) (negate pi)) (Point (negate pi) (negate pi)))
            , test "unprojects other points" (near (pr <| Point 0.523598775598 1.010683188683) (Point 0.523598775598 1.010683188683))
            , test "unprojects other points" (near (pr <| Point 8918060.964088084 6755099.410887127) (Point 8918060.964088084 6755099.410887127))
            ]


all : Test
all =
    suite
        "Leaflet.Geo.Projection.Merkator"
        [ projectSuite
        , unProjectSuite
        ]
