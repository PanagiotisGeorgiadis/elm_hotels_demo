module Utils.Handlers exposing (..)

import Html exposing (Attribute)
import Html.Events exposing (on)

import Json.Decode as Json

onChange : (String -> msg) -> Attribute msg
onChange handler =
  on "change" <| Json.map handler <| Json.at ["target", "value"] Json.string

-- import Json.Decode as Decode exposing (..)
--
-- type Msg
--   = NoOp
--   | InputChange String
--
-- type alias HtmlEvent =
--   { target : HtmlEventTarget
--   }
--
-- type alias HtmlEventTarget =
--   { className : String
--   , value : String
--   }
--
-- update msg model =
--   case msg of
--     InputChange str ->
--         let
--           _ = Debug.log "" str
--         in
--           ( model, Cmd.none )
--     _ ->
--       ( model, Cmd.none )
--
-- eventDecoder : Decode.Decoder HtmlEvent
-- eventDecoder =
--   Decode.map HtmlEvent
--     (Decode.field "target" eventTargetDecoder)
--
-- eventTargetDecoder : Decode.Decoder HtmlEventTarget
-- eventTargetDecoder =
--   Decode.map2 HtmlEventTarget (Decode.field "className" Decode.string) (Decode.field "value" Decode.string)
--
--
-- --main : Html msg
-- main =
--     input
--       [ type_ "text"
--         -- Decode.map : (a -> value) -> Decoder a -> Decoder value
--         , on "change" (Decode.map (\e -> InputChange e.target.value) eventDecoder)
--       ]
--       []
