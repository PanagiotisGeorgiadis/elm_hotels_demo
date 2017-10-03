module Components.SortControls.Model exposing (..)

type alias SortedModel =
  { starSortingDirection : Maybe SortDirection
  , ratingsSortingDirection : Maybe SortDirection
  , costSortingDirection : Maybe SortDirection
  }

type SortDirection
  = Ascending
  | Descending

init : SortedModel
init =
  SortedModel Nothing Nothing Nothing
