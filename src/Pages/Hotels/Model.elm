module Pages.Hotels.Model exposing (..)

import Data.Hotel exposing (..)
import RemoteData exposing (..)

import Utils.APIManager exposing (..)

import Components.FilterControls.Model as FilterControls exposing (..)
import Components.FilterControls.Update as FilterControls exposing (..)

import Components.SortControls.Model as SortControls exposing (..)
import Components.SortControls.Update as SortControls exposing (..)


type alias Model =
  { requestStatus : WebData (HotelsResult)
  , filterCriteria : FilterControls.FilteredModel
  , sortingCriteria : SortControls.SortedModel
  }

type Actions
    = FetchHotels (WebData HotelsResult)
    | FilteredCriteriaMsg (FilterControls.Msg)
    | SortControlsMsg (SortControls.Msg)

init : ( Model, Cmd Actions )
init =
  ( { requestStatus = Loading
    , filterCriteria = FilterControls.init
    , sortingCriteria = SortControls.init
    }, fetchHotels FetchHotels )
