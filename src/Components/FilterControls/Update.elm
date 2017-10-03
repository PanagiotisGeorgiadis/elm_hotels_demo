module Components.FilterControls.Update exposing (..)

import Components.FilterControls.Model exposing (..)

type Msg
  = UpdateLocationValue String
  | UpdateStarsValue String
  | UpdateMinPriceValue String
  | UpdateMaxPriceValue String
  | UpdateRatingsValue String
  -- | ApplyFilters
  | ResetFilters

update : Msg -> FilteredModel -> ( FilteredModel, Cmd Msg )
update msg model =
  case msg of
    UpdateLocationValue updatedLocationValue ->
      ( { model | selectedLocation = Just updatedLocationValue }, Cmd.none )


    UpdateMinPriceValue minPriceValue ->
      let
        minPrice = Result.withDefault 0 <| String.toFloat <| minPriceValue
        (updatedMinPrice, maxPrice) =
          case model.maxSelectedPrice of
            Just maxPrice ->
              if minPrice >= maxPrice then
                ( Just minPrice, Just <| minPrice + 100 )
              else
                ( Just minPrice, Just maxPrice )
            Nothing ->
              ( Just minPrice, Nothing )
      in
        ( { model | minSelectedPrice = updatedMinPrice, maxSelectedPrice = maxPrice }, Cmd.none )


    UpdateMaxPriceValue maxPriceValue ->
      let
        maxPrice = Result.withDefault 0 <| String.toFloat <| maxPriceValue
        ( updatedMaxPrice, minPrice ) =
          case model.minSelectedPrice of
            Just minPrice ->
              if maxPrice <= minPrice then
                ( Just maxPrice, Just <| maxPrice - 100 )
              else
                ( Just maxPrice, Just minPrice )
            Nothing ->
                ( Just maxPrice, Nothing )
      in
        ( { model | maxSelectedPrice = updatedMaxPrice, minSelectedPrice = minPrice }, Cmd.none )


    UpdateStarsValue updatedStarsValue ->
      let
        stars = Result.toMaybe <| String.toInt updatedStarsValue
      in
        ( { model | selectedStars = stars }, Cmd.none )


    UpdateRatingsValue updatedRatingsValue ->
      let
        ratings = Result.toMaybe <| String.toFloat updatedRatingsValue
      in
        ( { model | selectedRating = ratings }, Cmd.none )


    -- ApplyFilters ->
    --     ( { model | shouldFilter = True }, Cmd.none )


    ResetFilters ->
        ( { model
          | selectedLocation = Nothing
          , minSelectedPrice = Nothing
          , maxSelectedPrice = Nothing
          , selectedStars = Nothing
          , selectedRating = Nothing
          }, Cmd.none )
