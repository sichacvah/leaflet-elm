module Main (..) where

import Signal exposing (Signal)
import ElmTest exposing (consoleRunner, suite, Test)
import Console exposing (IO, run)
import Task
import Tests.Geometry.Point as Point
import Tests.Geometry.Transformation as Transformation
import Tests.Geometry.Bounds as Bounds
import Tests.Geo.Projection.Merkator as Merkator


mainSuite : Test
mainSuite =
    suite
        "Run all tests"
        [ Point.all
        , Bounds.all
        , Transformation.transformSuite
        , Transformation.untransformSuite
        , Merkator.projectSuite
        , Merkator.unProjectSuite
        ]


console : IO ()
console =
    consoleRunner mainSuite


port runner : Signal (Task.Task x ())
port runner =
    run console
