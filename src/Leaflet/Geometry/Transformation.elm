module Leaflet.Geometry.Transformation (..) where

import Leaflet.Geometry.Models exposing (Transformation, Point, TransformFuncType)


scale : Maybe Float -> Float
scale mbS =
    Maybe.withDefault 1 mbS


transform : ( Float, Float, Float, Float ) -> Point -> Maybe Float -> Point
transform ( a, b, c, d ) point maybeScale =
    let
        scale =
            Maybe.withDefault 1 maybeScale
    in
        Point (scale * (a * point.x + b)) (scale * (c * point.y + d))


untransform : ( Float, Float, Float, Float ) -> Point -> Maybe Float -> Point
untransform ( a, b, c, d ) point maybeScale =
    let
        scale =
            Maybe.withDefault 1 maybeScale
    in
        { point
            | x = (point.x / scale - b) / a
            , y = (point.y / scale - d) / c
        }


initTransformation : ( Float, Float, Float, Float ) -> Transformation
initTransformation ( a, b, c, d ) =
    Transformation (transform ( a, b, c, d )) (untransform ( a, b, c, d ))
