module Main (..) where

import Signal exposing (Signal)
import ElmTest exposing (consoleRunner, suite, Test)
import Console exposing (IO, run)
import Task
import Tests.Geometry.Point as Point
import Tests.Geometry.Transformation as Transformation
import Tests.Geometry.Bounds as Bounds
import Tests.Geo.Projection.Merkator as Merkator
import Tests.Geo.Projection.SphericalMerkator as SMerkator
import Tests.Geo.CRS.EPSG3857 as EPSG3857


mainSuite : Test
mainSuite =
    suite
        "Run all tests"
        [ Point.all
        , Bounds.all
        , Transformation.all
        , Merkator.all
        , SMerkator.all
        , EPSG3857.all
        ]


console : IO ()
console =
    consoleRunner mainSuite


port runner : Signal (Task.Task x ())
port runner =
    run console
