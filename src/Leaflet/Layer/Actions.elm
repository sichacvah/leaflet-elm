module Leaflet.Layer.Actions (..) where



type alias Event = String

type Action
  = NoOp
  | FireEvent Event
