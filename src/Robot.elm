module Robot exposing (Model, Msg, init, subscriptions, update, view)

import Browser
import Browser.Events
import Debug
import Html
import Html.Attributes as Attributes
import Html.Events as Events exposing (onClick)
import Json.Decode
import String


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown <| Json.Decode.map KeyPressed <| Json.Decode.field "key" Json.Decode.string


type alias Model =
    { x : Float
    , y : Float
    , up : String
    , down : String
    , left : String
    , right : String
    }


type Msg
    = KeyPressed String


init : Float -> Float -> String -> String -> String -> String -> Model
init x y up down right left =
    { x = x, y = y, up = up, down = down, right = right, left = left }


update : Float -> Msg -> Model -> Model
update movePixels msg model =
    case msg of
        KeyPressed button ->
            if button == model.up then
                { model | y = model.y - movePixels }

            else if button == model.down then
                { model | y = model.y + movePixels }

            else if button == model.right then
                { model | x = model.x + movePixels }

            else if button == model.left then
                { model | x = model.x - movePixels }

            else
                model


view : String -> String -> Model -> Html.Html Msg
view name color model =
    Html.div
        [ Attributes.style "background-color" color
        , Attributes.style "width" "5%"
        , Attributes.style "position" "absolute"
        , Attributes.style "left" <| String.fromFloat model.x ++ "px"
        , Attributes.style "top" <| String.fromFloat model.y ++ "px"
        ]
        [ Html.text name ]
