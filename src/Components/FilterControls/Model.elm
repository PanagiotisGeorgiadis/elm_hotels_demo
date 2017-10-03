module Components.FilterControls.Model exposing (..)

type alias FilteredModel =
  { selectedLocation : Maybe String
  , minSelectedPrice : Maybe Float
  , maxSelectedPrice : Maybe Float
  , selectedStars : Maybe Int
  , selectedRating : Maybe Float
  }

init : FilteredModel
init =
  FilteredModel Nothing Nothing Nothing Nothing Nothing
