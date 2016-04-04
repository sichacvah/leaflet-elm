module Leaflet.Geometry.Transformation (..) where

import Leaflet.Geometry.Models exposing (Transformation, Point)


type alias TransformFuncType =
    Point -> Maybe Float -> Point


transform : ( Float, Float, Float, Float ) -> TransformFuncType
transform ( a, b, c, d ) transformation point maybeScale =
    let
        scale =
            Maybe.withDefault 1 maybeScale
    in
        { point
            | x = scale * (a * point.x + b)
            , y = scale * (c * point.y + d)
        }


untransform : ( Float, Float, Float, Float ) -> TransformFuncType
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
