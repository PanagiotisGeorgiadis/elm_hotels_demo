module Components.FilterControls.View exposing (..)

import Html exposing (Attribute, Html, button, div, input, label, option, p, select, text)
import Html.Attributes exposing (class, for, name, step, title, type_, value)
import Html.Events exposing (onClick, onInput)

import Data.Hotel exposing (..)

import Components.FilterControls.Model exposing (..)
import Components.FilterControls.Update exposing (..)
import Components.FilterControls.Controls.PriceFilter exposing (..)
import Components.FilterControls.Controls.StarsFilter exposing (..)
import Components.FilterControls.Controls.RatingFilter exposing (..)
import Components.FilterControls.Controls.LocationFilter exposing (..)


renderFilterControls : FilteredModel -> Aggregates -> Html Msg
renderFilterControls model aggregates =
    div [ class "filtering_controls_container" ]
        [ p [] [ text "Filter By: " ]
        , renderLocationsFilter model aggregates.locations
        , renderStarsFilter model
        , renderRatingFilter model aggregates.ratingsRange
        , div [ class "price_filters_container" ]
          [ renderMinPriceFilter model aggregates.priceRange
          , renderMaxPriceFilter model aggregates.priceRange
          ]
        , renderFilterButtons
        ]


renderFilterButtons : Html Msg
renderFilterButtons =
    div [ class "filter_buttons_container" ]
        [
          -- button [ class "apply_filters_button filter_buttons", onClick ApplyFilters ] [ text "Apply Filters" ]
          button [ class "reset_filters_button filter_buttons noselect", onClick ResetFilters ] [ text "Reset Filters" ]
        ]
