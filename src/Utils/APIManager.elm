module Utils.APIManager exposing (..)

import Set exposing (..)
import Http exposing (get, send)
import Json.Decode as Decode exposing (..)

import RemoteData exposing (..)
import Json.Decode.Extra exposing ((|:))

import Data.Hotel exposing (..)

fetchHotels : (WebData (HotelsResult) -> b) -> Cmd b
fetchHotels action =
  let
    url =
      "https://api-holder-zarc.c9users.io/api/hotels"
  in
    Http.get url decodeHotels
      |> RemoteData.sendRequest
      |> Cmd.map action

decodeHotels : Decode.Decoder HotelsResult
decodeHotels =
  Decode.map (\ hotels ->
      HotelsResult hotels (getAggregates hotels) )
    (Decode.field "Establishments" (Decode.list hotelDecoder))

hotelDecoder : Decode.Decoder Hotel
hotelDecoder =
    Decode.succeed Hotel
      |: (Decode.field "EstablishmentId" Decode.int)
      |: (Decode.field "Name" Decode.string)
      |: (Decode.field "ImageUrl" Decode.string)
      |: (Decode.field "ThumbnailUrl" Decode.string)
      |: (Decode.field "MinCost" Decode.float)
      |: (Decode.field "Stars" Decode.int)
      |: (Decode.field "UserRating" Decode.float)
      |: (Decode.field "UserRatingCount" Decode.int)
      |: (Decode.field "UserRatingTitle" Decode.string)
      |: (Decode.field "EstablishmentType" Decode.string)
      |: (Decode.field "Location" Decode.string)
      |: (Decode.field "Distance" Decode.float)


getAggregates : List Hotel -> Aggregates
getAggregates hotels =
  Aggregates (getPriceRange hotels) (getDistanceRange hotels) (getLocations hotels) (getUserRatingRange hotels)

getPriceRange : List Hotel -> PriceRange
getPriceRange hotels =
  let
    minCost = List.foldl (\hotel result -> min hotel.minCost result ) 10000000 hotels
    maxCost = List.foldl (\hotel result -> max hotel.minCost result ) -10000000 hotels
  in
    PriceRange minCost maxCost

getDistanceRange : List Hotel -> DistanceRange
getDistanceRange hotels =
  let
    minDistance = List.foldl (\hotel result -> min hotel.distance result ) 10000000 hotels
    maxDistance = List.foldl (\hotel result -> max hotel.distance result ) -10000000 hotels
  in
    DistanceRange minDistance maxDistance

getLocations : List Hotel -> LocationsRange
getLocations =
    List.map .location >> Set.fromList >> Set.toList
    --locations = Set.toList <| Set.fromList <| List.foldl (\hotel resultList -> hotel.location :: resultList) [] hotels

getUserRatingRange : List Hotel -> RatingsRange
getUserRatingRange hotels =
  let
    minRating = List.foldl (\hotel result -> min hotel.userRating result ) 10000000 hotels
    maxRating = List.foldl (\hotel result -> max hotel.userRating result ) -10000000 hotels
  in
  RatingsRange minRating maxRating
