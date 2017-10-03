module Components.FilterControls.Controls.RatingFilter exposing (..)

import Html exposing (Html, div, label, input, text)
import Html.Attributes exposing (for, class, type_, value, step, title, name)
import Html.Events exposing (onInput)

import Data.Hotel exposing (..)
import Components.FilterControls.Model exposing (..)
import Components.FilterControls.Update exposing (..)


getDefaultRatingValue : Maybe Float -> Float
getDefaultRatingValue ratingValue =
  case ratingValue of
    Just rating ->
      rating
    Nothing ->
      -1.0


getLabelTextValue : String -> Float -> String
getLabelTextValue labelTextPrefix defaultValue =
  if (defaultValue == -1) then
    labelTextPrefix ++ "Not Selected"
  else
    labelTextPrefix ++ " <= " ++ toString defaultValue


getSliderDefaultValue : RatingsRange -> Float -> String
getSliderDefaultValue { minRating, maxRating } defaultValue =
  if (defaultValue == -1) then
    toString <| (minRating + maxRating) / 2
  else
    toString <| defaultValue


renderRatingFilter : FilteredModel -> RatingsRange -> Html Msg
renderRatingFilter model ratingsRange =
  let
    defaultValue = getDefaultRatingValue model.selectedRating
    labelText = getLabelTextValue "Rating: " defaultValue
    sliderValue = getSliderDefaultValue ratingsRange defaultValue
  in
    div [ class "ratings_filter_container" ]
    [
      label [ for "ratings_filter" ] [ text labelText],
      div [ class "ratings_slider_container" ]
      [
        input [ type_ "range"
              , class "ratings_slider"
              , Html.Attributes.min <| toString ratingsRange.minRating
              , Html.Attributes.max <| toString ratingsRange.maxRating
              , value <| sliderValue
              , step "0.5"
              , onInput UpdateRatingsValue
              , title <| sliderValue
              , name "ratings_filter"
              ] []
      ]
    ]
