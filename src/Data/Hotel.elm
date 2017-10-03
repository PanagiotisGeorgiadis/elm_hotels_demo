module Data.Hotel exposing (..)

type alias Hotel =
  { id : Int
  , name : String
  , imageUrl : String
  , thumbnailUrl : String
  , minCost : Float
  , stars : Int
  , userRating : Float
  , userRatingCount : Int
  , userRatingTitle : String
  , establishmentType : String
  , location : String
  , distance : Float
  }

type alias Aggregates =
  { priceRange : PriceRange
  , distanceRange : DistanceRange
  , locations : LocationsRange
  , ratingsRange : RatingsRange
  }

type alias PriceRange =
  { minCost : Float
  , maxCost : Float
  }

type alias DistanceRange =
  { minDistance : Float
  , maxDistance : Float
  }

type alias RatingsRange =
  { minRating : Float
  , maxRating : Float
  }

type alias LocationsRange = List String

type alias HotelsResult =
  { hotels : List Hotel
  , aggregates : Aggregates
  }
