module Pages.Hotels.Update exposing (..)

-- import RemoteData exposing (..)
import Pages.Hotels.Model exposing (..)

import Components.FilterControls.Update as FilterControls exposing (..)
import Components.SortControls.Update as SortControls exposing (..)

update : Actions -> Model -> ( Model, Cmd Actions )
update msg model =
  case msg of
    FetchHotels updatedRequestStatus ->
        ( { model | requestStatus = updatedRequestStatus }, Cmd.none )

    FilteredCriteriaMsg submsg ->
      let
        ( updatedModel, subcmd ) = FilterControls.update submsg model.filterCriteria
      in
        ( { model | filterCriteria = updatedModel }, Cmd.map FilteredCriteriaMsg subcmd )

    SortControlsMsg submsg ->
      let
        ( updatedModel, subcmd ) = SortControls.update submsg model.sortingCriteria
      in
        ( { model | sortingCriteria = updatedModel }, Cmd.map SortControlsMsg subcmd )

    -- FilterControlsExternalMsg submsg ->
    --   let
    --     ( updatedModel, subcmd, externalCmd ) = FilterControls.update submsg model.filterCriteria
    --   in
    --     ( { model | filterCriteria = updatedModel }, Cmd.map FilterControlsExternalMsg externalCmd)

    -- _ ->
    --   ( model, Cmd.none )

  --  FetchHotels updatedRequestStatus ->
  --    let
  --      _ = Debug.log "Fetch hotels cmd " updatedRequestStatus
  --    in
  --      ( { model | requestStatus = updatedRequestStatus }, Cmd.none )
