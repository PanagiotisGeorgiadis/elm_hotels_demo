module Main exposing (..)

import Html exposing (Html, text, div)

import RemoteData exposing (..)

-- import Data.Hotel exposing (..)
-- import Utils.APIManager as APIManager exposing (..)

import Pages.Hotels.Model as HotelsPage exposing (..)
import Pages.Hotels.View as HotelsPage exposing (..)
import Pages.Hotels.Update as HotelsPage exposing (..)

---- MODEL ----
type alias Model = {
    hotels: HotelsPage.Model
  }
-- type alias Model = {
--     requestStatus: WebData (HotelsResult)
--   }

init : (Model, Cmd Actions)
init =
  let
      (hotelsModel, hotelCmds) =
          HotelsPage.init
  in
    ( { hotels = hotelsModel }
    , Cmd.map HotelsPageActions hotelCmds )
-- init : ( Model, Cmd Actions )
-- init =
--     ( {
--         requestStatus = Loading
--       }, fetchHotels FetchHotels )

---- UPDATE ----
type Actions
    = HotelsPageActions HotelsPage.Actions
    -- | FetchHotels (WebData HotelsResult)

update : Actions -> Model -> ( Model, Cmd Actions )
update msg model =
  case msg of
    HotelsPageActions submsg ->
      let
        ( updatedModel, cmd ) = HotelsPage.update submsg model.hotels
      in
        ( { model | hotels = updatedModel }, Cmd.map HotelsPageActions cmd )

    -- FetchHotels updatedRequestStatus ->
    --   ( { model | requestStatus = updatedRequestStatus }, Cmd.none )

---- VIEW ----
view : Model -> Html Actions
view model =
    div []
        [
          Html.map HotelsPageActions <| HotelsPage.view <| model.hotels
          -- case model.requestStatus of
          --   NotAsked -> text <| "Not Asked..."
          --   Loading -> text <| "Loading.."
          --   Failure err -> text ("Error: " ++ toString err)
          --   Success hotels -> renderHotels hotels
        ]


-- renderHotels : HotelsResult -> Html Actions
-- renderHotels {hotels, aggregates} =
--     div
--       []
--       (List.map renderHotel hotels)
--
-- renderHotel : Hotel -> Html Actions
-- renderHotel hotel =
--     div
--       []
--       [text <| toString hotel.id]

---- PROGRAM ----
main : Program Never Model Actions
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
