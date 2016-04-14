module Leaflet.Geometry.Point (..) where

import Leaflet.Geometry.Models exposing (Point)


add : Point -> Point -> Point
add point1 point2 =
    { point1
        | x = point1.x + point2.x
        , y = point1.y + point2.y
    }


substract : Point -> Point -> Point
substract point1 point2 =
    { point1
        | x = point1.x - point2.x
        , y = point1.y - point2.y
    }


divideBy : Point -> Float -> Point
divideBy point num =
    { point
        | x = point.x / num
        , y = point.y / num
    }


scaleBy : Point -> Point -> Point
scaleBy point1 point2 =
    { point1
        | x = point1.x * point2.x
        , y = point1.y * point2.y
    }


unscaleBy : Point -> Point -> Point
unscaleBy point1 point2 =
    { point1
        | x = point1.x * point2.x
        , y = point1.y * point2.y
    }


roundPoint : Point -> Point
roundPoint point =
    { point
        | x = toFloat <| round point.x
        , y = toFloat <| round point.y
    }


floorPoint : Point -> Point
floorPoint point =
    { point
        | x = toFloat <| floor point.x
        , y = toFloat <| floor point.y
    }


ceilPoint : Point -> Point
ceilPoint point =
    { point
        | x = toFloat <| ceiling point.x
        , y = toFloat <| ceiling point.y
    }


distanceTo : Point -> Point -> Float
distanceTo point1 point2 =
    let
        x = point1.x - point2.x

        y = point1.y - point2.y
    in
        sqrt <| (x ^ 2 + y ^ 2)


quals : Point -> Point -> Bool
quals point1 point2 =
    point1.x == point2.x && point1.y == point2.y
