module Leaflet.Map.Models (..) where

import Leaflet.CRS.Models as CRSModels exposing (CRS)


type alias Options =
    { crs : CRS
    , fadeAnimation : Bool
    , trackResize : Bool
    , markerZoomAnimation : Bool
    , maxBoundsViscosity : Float
    , transform3DLimit : Float
    , zoomSnap : Int
    , zoomDelta : Int
    }


presectionLimitOf32bitFloat : Float
presectionLimitOf32bitFloat =
    8388608


initaialOptions : Options
initaialOptions =
    Options CRSModels.EPSG3857 True True True 0.0 presectionLimitOf32bitFloat 1 1
