module Utils.RoundingHelpers exposing (..)

roundToPreviousHundred : Float -> Int
roundToPreviousHundred cost =
  (round (cost / 100)) * 100
    -- if cost % 100 == 0 then
    --   cost
    -- else
    --   getPreviousHundred <| cost - 1

roundToNextHundred : Float -> Int
roundToNextHundred cost =
  (ceiling (cost / 100)) * 100
  -- if cost % 100 == 0 then
  --   cost
  -- else
  --   getNextHundred <| cost + 1

roundToClosestHundred : Float -> Int
roundToClosestHundred cost =
  (round (cost / 100)) * 100
