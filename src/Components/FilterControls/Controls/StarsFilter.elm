module Components.FilterControls.Controls.StarsFilter exposing (..)

import Html exposing (Html, div, text, label, select, option)
import Html.Attributes exposing (for, name, selected, class, title)
import Html.Events exposing (onClick)

import Components.FilterControls.Model exposing (..)
import Components.FilterControls.Update exposing (..)


updateStarSelectionsClassNames : Int -> Int -> String
updateStarSelectionsClassNames selectedValue starValue =
    if starValue <= selectedValue then
      "stars_selection selected"
    else
      "stars_selection"


renderStarSelectionOption : String -> String -> Html Msg
renderStarSelectionOption starValue className =
  div [ class className
      , title starValue
      , onClick <| UpdateStarsValue starValue
      ] []


renderStarsFilter : FilteredModel -> Html Msg
renderStarsFilter model =
  let
    starValues = [1, 2, 3, 4, 5]
    starClassNames =
      case model.selectedStars of
        Just value ->
          List.foldr (\starValue resultList -> updateStarSelectionsClassNames value starValue :: resultList ) [] starValues
        Nothing ->
          List.repeat 5 "stars_selection"

    starSelectionElements = List.map2 renderStarSelectionOption (List.map toString starValues) starClassNames
    starOptions = List.append
                    ( div [ class "stars_selection_offset", title "0 Stars", onClick <| UpdateStarsValue "0" ] [] :: starSelectionElements )
                    [ div [ class "stars_selection_offset", title "5 Stars", onClick <| UpdateStarsValue "5" ] [] ]
  in
    div [ class "stars_filter_container"]
    [
      label [ for "stars_filter" ] [ text "Stars: "],
      div [ class "stars_selection_container" ]
        starOptions
    ]
