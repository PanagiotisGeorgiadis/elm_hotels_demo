module Utils.SortingHelpers exposing (..)

import Data.Hotel exposing (..)
import Components.SortControls.Model exposing (..)

sortByStars : Maybe SortDirection -> List Hotel -> List Hotel
sortByStars starSortingDirection hotels =
  case starSortingDirection of
    Just Ascending ->
      List.sortBy .stars hotels
    Just Descending ->
      List.reverse <| List.sortBy .stars hotels
    Nothing ->
      hotels


sortByRating : Maybe SortDirection -> List Hotel -> List Hotel
sortByRating ratingsSortingDirection hotels =
  case ratingsSortingDirection of
    Just Ascending ->
      List.sortBy .userRating hotels
    Just Descending ->
      List.reverse <| List.sortBy .userRating hotels
    Nothing ->
      hotels

sortByCost : Maybe SortDirection -> List Hotel -> List Hotel
sortByCost costSortingDirection hotels =
  case costSortingDirection of
    Just Ascending ->
      List.sortBy .minCost hotels
    Just Descending ->
      List.reverse <| List.sortBy .minCost hotels
    Nothing ->
      hotels
