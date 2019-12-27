port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (src, id, class)

import Json.Encode as E

---- PORTS ----

port cache : E.Value -> Cmd msg

port cake : E.Value -> Cmd msg

---- MODEL ----


type alias Model = List String

init : ( Model, Cmd Msg )
init =
    ( ["L_LUpnjgPso", "bYOE4XnrNeo", "3RMqRC5fzd0"], cake <| encodeModel ["L_LUpnjgPso", "bYOE4XnrNeo", "3RMqRC5fzd0"] )



---- UPDATE ----


type Msg
    = NoOp
    | SetVideo String
    | AddAudio String
    | RemoveAudio String

encodeModel : Model -> E.Value
encodeModel model = E.list E.string model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetVideo videoId ->
            case model of
                [] -> ( [ videoId ], cake <| encodeModel model )
                video :: audio -> ( videoId :: audio, cake <| encodeModel model )
        AddAudio videoId ->
            case model of
                [] -> ( [ "", videoId ], cake <| encodeModel model )
                videos -> ( videos ++ [ videoId ], cake <| encodeModel model )
        RemoveAudio videoId ->
            case model of
                [] -> ( model, cake <| encodeModel model )
                video :: audio -> ( video :: (List.filter (\v -> v /= videoId) audio), cake <| encodeModel model )
        _ ->
            ( model, Cmd.none )


---- VIEW ----


view : Model -> Html Msg
view model =
    case model of
        video :: audio ->
            div []
                (div [ id video ] [] :: List.map (\v -> div [ id v, class "hidden" ] []) audio)
        _ -> div [] []


---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
