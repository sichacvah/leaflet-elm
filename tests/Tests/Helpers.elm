module Tests.Helpers (..) where

import Leaflet.Geometry.Bounds exposing (getSize)
import Leaflet.Geometry.Models exposing (Bounds)
import ElmTest exposing (..)


within : Float -> Float -> Float -> Bool
within min max a =
    a >= min && a <= max


assertBounds : Maybe Bounds -> Float -> Assertion
assertBounds mBounds worldSize =
    case mBounds of
      Nothing ->
        fail ("Nothing " ++ (toString worldSize))
      Just bounds ->
        let size =
              getSize bounds
        in
          if (size.x == worldSize && size.y == worldSize) then
            pass
          else
            fail ((toString size) ++ (toString worldSize))



assertNear : Maybe Float -> { x : Float, y : Float } -> { x : Float, y : Float } -> Assertion
assertNear maybeDelta obj expected =
    let
        delta = Maybe.withDefault 1.0 maybeDelta
    in
        if
            (within (expected.x - delta) (expected.x + delta) obj.x)
                && (within (expected.y - delta) (expected.y + delta) obj.y)
        then
            pass
        else
            fail ((toString obj) ++ (toString expected))


assertNearLatLng : Maybe Float -> { a | lat : Float, lng : Float } -> { a | lat : Float, lng : Float } -> Assertion
assertNearLatLng maybeDelta obj expected =
  let
      delta = Maybe.withDefault 1e-4 maybeDelta
  in
      if 
         (within (expected.lat - delta) (expected.lat + delta) obj.lat)
            && (within (expected.lng - delta) (expected.lng + delta) obj.lng)
      then
          pass
       else
         fail ((toString obj) ++ (toString expected))



