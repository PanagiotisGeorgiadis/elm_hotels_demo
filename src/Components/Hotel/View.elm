module Components.Hotel.View exposing (..)

import Html exposing (Html, text, div, br, img, p)
import Html.Attributes exposing (id, class, src, title)

import Data.Hotel exposing (..)


view : Hotel -> Html Never
view hotel =
    div [ id <| toString hotel.id, class "hotel_container" ]
      [
        Html.map never <| renderHotelImage hotel.imageUrl,
        Html.map never <| renderHotelInfoContainer hotel.name hotel.stars hotel.location hotel.minCost,
        Html.map never <| renderUserRatingContainer hotel.userRatingTitle hotel.userRating hotel.userRatingCount
      ]

renderHotelImage : String -> Html Never
renderHotelImage imageUrl =
  div [ class "hotel_image_container" ]
  [
    img [ src imageUrl ] []
  ]

renderHotelInfoContainer : String -> Int -> String -> Float -> Html Never
renderHotelInfoContainer name stars location minCost =
  div [ class "hotel_information_container" ]
  [
    div [ class "hotel_information_top_container" ]
    [
      renderHotelStars stars,
      renderHotelInfoParagraph "hotel_min_cost" <| toString minCost ++ "£"
    ],
    div [ class "hotel_information_bottom_container" ]
    [
      renderHotelInfoParagraph "hotel_name" name,
      renderHotelInfoParagraph "hotel_location" location
    ]
  ]

renderUserRatingContainer : String -> Float -> Int -> Html Never
renderUserRatingContainer userRatingTitle userRatingAverage userRatingCount =
  let
    ratingCount = toString userRatingCount
    ratingAverage = toString userRatingAverage
  in
    div [ class "user_rating_container" ]
    [
      div [ class "total_ratings_container" ]
      [
        renderHotelInfoParagraph "" ratingCount,
        renderHotelInfoParagraph "" "Ratings"
      ],
      div [ class "visual_ratings_container" ]
      [
        renderHotelInfoParagraph "user_rating_title" userRatingTitle,
        renderRatingImage userRatingAverage
      ]
    ]

renderHotelInfoParagraph : String -> String -> Html Never
renderHotelInfoParagraph className name =
  p [ class className ]
  [
    text name
  ]

renderHotelStars : Int -> Html Never
renderHotelStars stars =
    div [ class "hotel_stars" ]
    ( List.map (\_ -> img [ class "star_image", src "/star.svg"] []) <| List.repeat stars 0 )

renderRatingImage : Float -> Html Never
renderRatingImage ratingAverage =
  let
    ratingAverageText = toString ratingAverage
  in
    if ratingAverage > 0 && ratingAverage <= 1 then
      div [ class "visual_rating visual_rating_0_5", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 1 && ratingAverage <= 2 then
      div [ class "visual_rating visual_rating_1", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 2 && ratingAverage <= 3 then
      div [ class "visual_rating visual_rating_1_5", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 3 && ratingAverage <= 4 then
      div [ class "visual_rating visual_rating_2", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 4 && ratingAverage <= 5 then
      div [ class "visual_rating visual_rating_2_5", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 5 && ratingAverage <= 6 then
      div [ class "visual_rating visual_rating_3", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 6 && ratingAverage <= 7 then
      div [ class "visual_rating visual_rating_3_5", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 7 && ratingAverage <= 8 then
      div [ class "visual_rating visual_rating_4", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 8 && ratingAverage <= 9 then
      div [ class "visual_rating visual_rating_4_5", title ("Average Rating: " ++ ratingAverageText) ] []
    else if ratingAverage > 9 && ratingAverage <= 10 then
      div [ class "visual_rating visual_rating_5", title ("Average Rating: " ++ ratingAverageText) ] []
    else
      div [ class "visual_rating visual_rating_0", title ("Average Rating: " ++ ratingAverageText) ] []
