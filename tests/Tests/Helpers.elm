module Tests.Helpers (..) where

import ElmTest exposing (..)


within : Float -> Float -> Float -> Bool
within min max a =
    a >= min && a <= max


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
