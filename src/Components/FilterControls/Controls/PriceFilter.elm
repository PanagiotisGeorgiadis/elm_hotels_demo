module Components.FilterControls.Controls.PriceFilter exposing (..)

import Html exposing (Html, div, label, text, input)
import Html.Attributes exposing (for, class, type_, value, step, title, name)
import Html.Events exposing (onInput)

import Data.Hotel exposing (..)
import Utils.RoundingHelpers exposing (roundToPreviousHundred, roundToNextHundred, roundToClosestHundred)

import Components.FilterControls.Model exposing (..)
import Components.FilterControls.Update exposing (..)


getDefaultPriceValue : Maybe Float -> Int
getDefaultPriceValue priceValue =
  case priceValue of
    Just price ->
      floor price
    Nothing ->
      -1


getLabelTextValue : String -> Int -> String
getLabelTextValue labelTextPrefix defaultValue =
  if (defaultValue == -1) then
    labelTextPrefix ++ "Not Selected"
  else
    labelTextPrefix ++ toString defaultValue


getSliderDefaultValue : PriceRange -> Int -> String
getSliderDefaultValue {minCost, maxCost} defaultValue =
  if (defaultValue == -1) then
    toString <| roundToClosestHundred <| (minCost + maxCost) / 2
  else
    toString <| defaultValue


renderMinPriceFilter : FilteredModel -> PriceRange -> Html Msg
renderMinPriceFilter model priceRange =
  let
    inputName = "min_price_filter"

    minCost = toString <| roundToPreviousHundred priceRange.minCost
    maxCost = toString <| roundToNextHundred <| priceRange.maxCost - 100

    defaultValue = getDefaultPriceValue model.minSelectedPrice

    labelText = getLabelTextValue "Min Price: " defaultValue
    sliderValue = getSliderDefaultValue priceRange defaultValue
  in
    renderPriceSliderFilter inputName labelText minCost maxCost sliderValue UpdateMinPriceValue


renderMaxPriceFilter : FilteredModel -> PriceRange -> Html Msg
renderMaxPriceFilter model priceRange =
  let
    inputName = "max_price_filter"

    minCost = toString <| roundToPreviousHundred <| priceRange.minCost + 100
    maxCost = toString <| roundToNextHundred priceRange.maxCost

    defaultValue = getDefaultPriceValue model.maxSelectedPrice

    labelText = getLabelTextValue "Max Price: " defaultValue
    sliderValue = getSliderDefaultValue priceRange defaultValue
  in
    renderPriceSliderFilter inputName labelText minCost maxCost sliderValue UpdateMaxPriceValue


renderPriceSliderFilter : String -> String -> String -> String -> String -> ( String -> Msg ) -> Html Msg
renderPriceSliderFilter inputName labelText minCost maxCost sliderValue action =
  div []
  [
    label [ for inputName ] [ text <| labelText],
    div [ class "price_slider_container" ]
    [
      input [ type_ "range"
            , class "price_slider"
            , Html.Attributes.min minCost
            , Html.Attributes.max maxCost
            , value <| sliderValue
            , step "100"
            , onInput action
            , title <| sliderValue
            , name inputName
            ] []
    ]
  ]
