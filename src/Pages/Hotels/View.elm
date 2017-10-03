module Pages.Hotels.View exposing (..)

import Html exposing (Html, text, div, br, select, option, label, p)
import Html.Attributes exposing (class, name, for)
import RemoteData exposing (..)

import Utils.FilteringHelpers exposing (..)
import Utils.SortingHelpers exposing (..)

import Data.Hotel exposing (..)
import Pages.Hotels.Model exposing (..)

import Components.Hotel.View as Hotel exposing (view)
import Components.SortControls.View as SortControls exposing (..)
import Components.FilterControls.View as FilterControls exposing (..)

view : Model -> Html Actions
view model =
    case model.requestStatus of
      NotAsked ->
        text "Not asked.."
      Loading ->
        text "Loading ..."
      Failure err ->
        text ("Error: " ++ toString err)
      Success data ->
        renderHotelsPage model data

renderHotelsPage : Model -> HotelsResult -> Html Actions
renderHotelsPage { filterCriteria, sortingCriteria } { hotels, aggregates } =
  div [ class "hotels_page_container" ]
  [
    div [ class "controls_container" ]
    [
      Html.map SortControlsMsg <| SortControls.renderSortControls sortingCriteria
    , Html.map FilteredCriteriaMsg <| FilterControls.renderFilterControls filterCriteria aggregates
    ],
    div [ class "hotels_list_container" ]
    [
      -- if filterCriteria.shouldFilter then
        Html.map never
          <| renderHotels
          <| sortByStars sortingCriteria.starSortingDirection
          <| sortByRating sortingCriteria.ratingsSortingDirection
          <| sortByCost sortingCriteria.costSortingDirection
          <| List.filter (\item -> applyLocationFilter item filterCriteria.selectedLocation)
          <| List.filter (\item -> applyStarsFilter item filterCriteria.selectedStars)
          <| List.filter (\item -> applyRatingsFilter item filterCriteria.selectedRating)
          <| List.filter (\item -> applyMinPriceFilter item filterCriteria.minSelectedPrice)
          <| List.filter (\item -> applyMaxPriceFilter item filterCriteria.maxSelectedPrice) hotels
          -- <| List.filter (\item -> applyPriceFilter item filterCriteria.maxPrice) hotels
      -- else
        -- Html.map never <| renderHotels hotels
    ],
    div [ class "filler_container" ] []
  ]

renderHotels : List Hotel -> Html Never
renderHotels hotels =
    div []
      (List.map Hotel.view (List.take 50 hotels))

-- renderHotel : Hotel -> Html Actions
-- renderHotel hotel =
--     div
--       []
--       [text <| toString hotel.id]
