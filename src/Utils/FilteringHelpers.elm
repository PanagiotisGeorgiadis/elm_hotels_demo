module Utils.FilteringHelpers exposing (..)

import Data.Hotel exposing (..)

applyLocationFilter : Hotel -> Maybe String -> Bool
applyLocationFilter item locationFilter =
  case locationFilter of
    Just location ->
      item.location == location
    Nothing ->
      True


applyStarsFilter : Hotel -> Maybe Int -> Bool
applyStarsFilter item starsFilter =
  case starsFilter of
    Just stars ->
      -- item.stars <= stars
      item.stars == stars
    Nothing ->
      True


applyMinPriceFilter : Hotel -> Maybe Float -> Bool
applyMinPriceFilter item priceFilter =
  case priceFilter of
    Just minPrice ->
      item.minCost >= minPrice
    Nothing ->
      True


applyMaxPriceFilter : Hotel -> Maybe Float -> Bool
applyMaxPriceFilter item priceFilter =
  case priceFilter of
    Just maxPrice ->
      item.minCost <= maxPrice
    Nothing ->
      True


applyRatingsFilter item ratingsFilter =
  case ratingsFilter of
    Just ratingValue ->
      item.userRating <= ratingValue
    Nothing ->
      True


-- applyPriceFilter : Hotel -> Maybe Float -> Bool
-- applyPriceFilter item priceFilter =
--   case priceFilter of
--     Just price ->
--       item.minCost > price
--     Nothing ->
--       True
