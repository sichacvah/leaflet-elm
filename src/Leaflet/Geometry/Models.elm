module Leaflet.Geometry.Models (..) where


type alias Transformation =
    { transform : Point -> Maybe Float -> Point
    , untransform : Point -> Maybe Float -> Point
    }


type alias Point =
    { x : Float
    , y : Float
    }


type alias Bounds =
    { min : Point
    , max : Point
    }


initBounds : Point -> Point -> Bounds
initBounds point1 point2 =
    let
        minX = min point1.x point2.x

        maxX = max point1.x point2.x

        minY = min point1.y point2.y

        maxY = max point1.y point2.y
    in
        Bounds (Point minX minY) (Point maxX maxY)


initPoint : Bool -> Float -> Float -> Point
initPoint round x y =
    if round then
        Point (round x) (round y)
    else
        Point x y
