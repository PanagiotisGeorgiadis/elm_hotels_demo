module Components.SortControls.Update exposing (..)

import Components.SortControls.Model exposing (..)

type Msg
  = StarsAscending
  | StarsDescending
  | RatingsAscending
  | RatingsDescending
  | CostAscending
  | CostDescending
  | SortingCriteriaReset



update : Msg -> SortedModel -> ( SortedModel, Cmd Msg )
update msg model =
  case msg of
    StarsAscending ->
      ( { model
        | starSortingDirection = Just Ascending
        , ratingsSortingDirection = Nothing
        , costSortingDirection = Nothing
        }, Cmd.none )

    StarsDescending ->
      ( { model
        | starSortingDirection = Just Descending
        , ratingsSortingDirection = Nothing
        , costSortingDirection = Nothing
        }, Cmd.none )

    RatingsAscending ->
      ( { model
        | starSortingDirection = Nothing
        , ratingsSortingDirection = Just Ascending
        , costSortingDirection = Nothing
        }, Cmd.none )

    RatingsDescending ->
      ( { model
        | starSortingDirection = Nothing
        , ratingsSortingDirection = Just Descending
        , costSortingDirection = Nothing
        }, Cmd.none )

    CostAscending ->
      ( { model
        | starSortingDirection = Nothing
        , ratingsSortingDirection = Nothing
        , costSortingDirection = Just Ascending
        }, Cmd.none )

    CostDescending ->
      ( { model
        | starSortingDirection = Nothing
        , ratingsSortingDirection = Nothing
        , costSortingDirection = Just Descending
        }, Cmd.none )

    SortingCriteriaReset ->
      ( { model
        | starSortingDirection = Nothing
        , ratingsSortingDirection = Nothing
        , costSortingDirection = Nothing
        }, Cmd.none )
