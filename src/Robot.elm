module Robot exposing (init, subscriptions, update, view)

import Browser
import Browser.Events
import Debug
import Html
import Html.Attributes as Attributes
import Html.Events as Events exposing (onClick)
import Json.Decode
import String


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown <| Json.Decode.map KeyPressed <| Json.Decode.field "key" Json.Decode.string


type alias Model =
    { x : Float
    , y : Float
    }


type Msg
    = KeyPressed String


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { x = 200, y = 200 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        _ =
            Debug.log "msg" msg
    in
    case msg of
        KeyPressed button ->
            case button of
                "ArrowUp" ->
                    ( { model | y = model.y - 5 }, Cmd.none )

                "ArrowDown" ->
                    ( { model | y = model.y + 5 }, Cmd.none )

                "ArrowRight" ->
                    ( { model | x = model.x + 5 }, Cmd.none )

                "ArrowLeft" ->
                    ( { model | x = model.x - 5 }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div
        [ Attributes.style "background-color" "blue"
        , Attributes.style "width" "50px"
        , Attributes.style "position" "absolute"
        , Attributes.style "left" (String.fromFloat model.x ++ "px")
        , Attributes.style "top" (String.fromFloat model.y ++ "px")
        ]
        [ Html.text "I'm a robot" ]
