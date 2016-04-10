module Tests.Geometry.Point (..) where

import ElmTest exposing (..)
import Leaflet.Geometry.Models exposing (Point)
import Leaflet.Geometry.Point exposing (..)


firstX : Float
firstX =
    10.5


secondX : Float
secondX =
    2.2


firstY : Float
firstY =
    11.5


secondY : Float
secondY =
    3.5


firstPoint : Point
firstPoint =
    Point firstX firstY


secondPoint : Point
secondPoint =
    Point secondX secondY


addPointResult : Point
addPointResult =
    Point (firstX + secondX) (firstY + secondY)


substractPointResult : Point
substractPointResult =
    Point (firstX - secondX) (firstY - secondY)


scaleResult : Point
scaleResult =
    Point (firstX * secondX) (firstY * secondY)


roundResult : Point
roundResult =
    Point (toFloat <| round firstX) (toFloat <| round firstY)


floorResult : Point
floorResult =
    Point (toFloat <| floor firstX) (toFloat <| floor firstY)


ceilResult : Point
ceilResult =
    Point (toFloat <| ceiling firstX) (toFloat <| ceiling firstY)


distanceResult : Float
distanceResult =
    sqrt <| (firstX - secondX) ^ 2 + (firstY - secondY) ^ 2


all : Test
all =
    suite
        "Point helper function test suite"
        [ test "#addition" (assertEqual (add firstPoint secondPoint) addPointResult)
        , test "#substraction" (assertEqual (substract firstPoint secondPoint) substractPointResult)
        , test "#scalation" (assertEqual (scaleBy firstPoint secondPoint) scaleResult)
        , test "#round" (assertEqual (roundPoint firstPoint) roundResult)
        , test "#floor" (assertEqual (floorPoint firstPoint) floorResult)
        , test "#ceil" (assertEqual (ceilPoint firstPoint) ceilResult)
        , test "#distance" (assertEqual (distanceTo firstPoint secondPoint) distanceResult)
        , test "#quals" (assertEqual (quals firstPoint secondPoint) False)
        ]
