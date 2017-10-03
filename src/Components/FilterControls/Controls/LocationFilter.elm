module Components.FilterControls.Controls.LocationFilter exposing (..)

import Html exposing (Html, div, label, text, select, option, br)
import Html.Attributes exposing (for, name, selected, class)

import Data.Hotel exposing (..)
import Utils.Handlers exposing (..)

import Components.FilterControls.Model exposing (..)
import Components.FilterControls.Update exposing (..)

renderOptionWithDefault : String -> String -> Html Msg
renderOptionWithDefault defaultValue value =
  option [ selected (defaultValue == value) ] [ text value ]

renderLocationsFilter : FilteredModel -> LocationsRange -> Html Msg
renderLocationsFilter model locations =
  let
    locationOptions =
      case model.selectedLocation of
        Just value ->
          List.map (\location -> renderOptionWithDefault value location ) locations
        Nothing ->
          let
            defaultOption = option [] [ text "Any" ]
            options = List.map (\location -> option [] [text location] ) locations
          in
            defaultOption :: options
  in
    div [ class "location_filter_container" ]
    [
      label [ for "locations_filter" ] [ text "Location: " ],
      select [ name "locations_filter", onChange UpdateLocationValue ]
        locationOptions
    ]

-- renderLocationsFilter : FilteredModel -> LocationsRange -> Html Msg
-- renderLocationsFilter model locations =
--   let
--     sortedLocations = List.sort locations
--     options = List.map (\location ->
--         let
--           optionSelected = case model.selectedLocation of
--                             Just a ->
--                               location == a
--                             Nothing ->
--                               False
--         in
--           option [ selected optionSelected ] [text location]) locations
--   in
--     div []
--     [
--       label [ for "locations_filter" ] [ text "Location: " ],
--       select [ name "locations_filter", onChange UpdateLocationValue ]
--         options
--     ]
