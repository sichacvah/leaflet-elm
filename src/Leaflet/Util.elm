module Leaflet.Util (..) where


formatNum : Float -> Float -> Float
formatNum num digits =
    let
        pow =
            10 ^ digits
    in
        (toFloat (round <| num * pow)) / pow


wrapNum : Float -> ( Float, Float ) -> Bool -> Float
wrapNum x ( min, max ) includeMax =
    let
        d = max - min
    in
        if includeMax && x == max then
            x
        else
            (x - min % d + d) % d + min
