module Tests.Geometry.Bounds (..) where

import ElmTest exposing (..)
import Leaflet.Geometry.Models exposing (Point, Bounds, initPoint)
import Leaflet.Geometry.Bounds exposing (..)


point1Min : Point
point1Min =
    Point 1.2 3.5


point1Max : Point
point1Max =
    Point 2.2 4.5


point2Min : Point
point2Min =
    Point 10.1 11.6


point2Max : Point
point2Max =
    Point 21.1 22.3


point3Min : Point
point3Min =
    Point 12.3 14.5


point3Max : Point
point3Max =
    Point 18.3 20.0


bounds1 : Bounds
bounds1 =
    Bounds point1Min point1Max


bounds1Center : Bool -> Point
bounds1Center needRound =
    initPoint needRound ((1.2 + 2.2) / 2) ((3.5 + 4.5) / 2)


bounds2 : Bounds
bounds2 =
    Bounds point2Min point2Max


bounds2Size : Point
bounds2Size =
    Point (point2Max.x - point2Min.x) (point2Max.y - point2Min.y)


bounds3 : Bounds
bounds3 =
    Bounds point3Min point3Max


bounds4 : Bounds
bounds4 =
    Bounds (Point 1.0 1.0) (Point 7.0 5.0)


bounds5 : Bounds
bounds5 =
    Bounds (Point 3.0 2.0) (Point 9.0 7.0)


bounds6 : Bounds
bounds6 =
    Bounds (Point 2.0 1.0) (Point 6.0 4.0)


all : Test
all =
    suite
        "Bounds helpers functions test suite"
        [ test "Get center function without round" (assertEqual (getCenter False bounds1) (bounds1Center False))
        , test "Get center function rounded" (assertEqual (getCenter True bounds1) (bounds1Center True))
        , test "Get bottom left point of Bounds" (assertEqual (getBottomLeft bounds2) point2Min)
        , test "Get top right point of Bounds" (assertEqual (getTopRight bounds2) point2Max)
        , test "Get size of bounds" (assertEqual (getSize bounds2) bounds2Size)
        , test "Bounds1 not contains Bounds2" (assertEqual (contains bounds1 (BoundsProc bounds2)) False)
        , test "Bounds2 contains Bounds3" (assertEqual (contains bounds2 (BoundsProc bounds3)) True)
        , test "Bounds2 contains point3Min" (assertEqual (contains bounds2 (PointProc point3Min)) True)
        , test "Bounds4 intersects Bounds5" (assertEqual (intersects bounds4 bounds5) True)
        , test "Bounds5 intersects Bounds4" (assertEqual (intersects bounds5 bounds4) True)
        , test "Bounds4 not overlaps Bounds6" (assertEqual (overlaps bounds4 bounds6) True)
        , test "Bounds2 overlaps Bounds3" (assertEqual (overlaps bounds2 bounds3) True)
        ]
