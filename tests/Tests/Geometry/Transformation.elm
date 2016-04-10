module Tests.Geometry.Transformation (..) where

import ElmTest exposing (..)
import Leaflet.Geometry.Models exposing (Point, Bounds, Transformation)
import Leaflet.Geometry.Transformation exposing (..)


t : Transformation
t =
    initTransformation ( 1, 2, 3, 4 )


p : Point
p =
    Point 10.0 20.0


transformSuite : Test
transformSuite =
    suite
        "#transform"
        [ test "performs a transformation" (assertEqual (t.transform p (Just 2)) (Point 24.0 128.0))
        , test "assumes a scale of 1 if not specified" (assertEqual (t.transform p Nothing) (Point 12.0 64.0))
        ]


untransformSuite : Test
untransformSuite =
    suite
        "#untransform"
        [ test "performs a reverse transformation" untransformWithScale
        , test "assumes a scale of 1 if not specified" untransformWithoutScale
        ]


untransformWithScale : Assertion
untransformWithScale =
    let
        p2 = t.transform p (Just 2)

        p3 = t.untransform p2 (Just 2)
    in
        assertEqual p3 p


untransformWithoutScale : Assertion
untransformWithoutScale =
    let
        p1 = Point 12.0 64.0

        p2 = Point 10.0 20.0
    in
        assertEqual (t.untransform p1 Nothing) p2
