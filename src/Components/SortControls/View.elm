module Components.SortControls.View exposing (..)

import Html exposing (Html, text, div, p, select, option, text, button, img)
import Html.Attributes exposing (class, name, src)
import Html.Events exposing (onClick)

import Components.SortControls.Model exposing (..)
import Components.SortControls.Update exposing (..)


renderSortControls : SortedModel -> Html Msg
renderSortControls sortingCriteria =
  div [ class "sorting_controls_container" ]
  [
    p [] [text "Sort By: "],
    renderSortingButtons sortingCriteria
  ]


renderSortingButtons : SortedModel -> Html Msg
renderSortingButtons sortingCriteria =
  let

    starsContainerClassName = "sorting_control noselect stars_control"
    ratingContainerClassName = "sorting_control noselect rating_control"
    costContainerClassName = "sorting_control noselect cost_control"

    ( starsSortingText, starsImgSource, starsImgClassName, starsSortingAction ) =
      case sortingCriteria.starSortingDirection of
        Just Ascending ->
          ( "Stars Ascending", "/sorting_arrow_white.png", "sorting_direction_indicator ascending", StarsDescending )
        Just Descending ->
          ( "Stars Descending", "/sorting_arrow_white.png", "sorting_direction_indicator descending", SortingCriteriaReset )
        Nothing ->
          ( "Stars", "/sorting_dash_white.png", "sorting_direction_indicator", StarsAscending )

    ( ratingsSortingText, ratingsImgSource, ratingsImgClassName, ratingsSortingAction ) =
      case sortingCriteria.ratingsSortingDirection of
        Just Ascending ->
          ( "Ratings Ascending", "/sorting_arrow_white.png", "sorting_direction_indicator ascending", RatingsDescending )
        Just Descending ->
          ( "Ratings Descending", "/sorting_arrow_white.png", "sorting_direction_indicator descending", SortingCriteriaReset )
        Nothing ->
          ( "Ratings", "/sorting_dash_white.png", "sorting_direction_indicator", RatingsAscending )

    ( costSortingText, costImgSource, costImgClassName, costSortingAction ) =
      case sortingCriteria.costSortingDirection of
        Just Ascending ->
          ( "Cost Ascending", "/sorting_arrow_white.png", "sorting_direction_indicator ascending", CostDescending )
        Just Descending ->
          ( "Cost Descending", "/sorting_arrow_white.png", "sorting_direction_indicator descending", SortingCriteriaReset )
        Nothing ->
          ( "Cost", "/sorting_dash_white.png", "sorting_direction_indicator", CostAscending )
  in
    div [ class "sorting_controls"]
    [
      renderSortingButton starsContainerClassName starsSortingText starsImgSource starsImgClassName starsSortingAction,
      renderSortingButton ratingContainerClassName ratingsSortingText ratingsImgSource ratingsImgClassName ratingsSortingAction,
      renderSortingButton costContainerClassName costSortingText costImgSource costImgClassName costSortingAction
    ]


renderSortingButton : String -> String -> String -> String -> Msg -> Html Msg
renderSortingButton containerClassName buttonText imgSource imgClassName action =
  div
    [ class containerClassName
    , onClick action
    ]
    [ text buttonText
    , img
      [ src imgSource
      , class imgClassName
      ] []
    ]
