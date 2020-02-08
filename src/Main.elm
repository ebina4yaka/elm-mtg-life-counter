module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { player1 : Player
    , player2 : Player
    }


type alias Player =
    { lifePoint : Int
    }


type Msg
    = DamagePlayer1
    | RecoveryPlayer1
    | DamagePlayer2
    | RecoveryPlayer2
    | Reset


init : Model
init =
    { player1 =
        { lifePoint = 20
        }
    , player2 =
        { lifePoint = 20
        }
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        DamagePlayer1 ->
            let
                recoveredPlayer1 =
                    recovery model.player1
            in
            { model | player1 = recoveredPlayer1 }

        RecoveryPlayer1 ->
            let
                damagedPlayer1 =
                    damage model.player1
            in
            { model | player1 = damagedPlayer1 }

        DamagePlayer2 ->
            let
                recoveredPlayer2 =
                    recovery model.player2
            in
            { model | player2 = recoveredPlayer2 }

        RecoveryPlayer2 ->
            let
                damagedPlayer2 =
                    damage model.player2
            in
            { model | player2 = damagedPlayer2 }

        Reset ->
            let
                newPlayer =
                    { lifePoint = 20 }
            in
            { model
                | player1 = newPlayer
                , player2 = newPlayer
            }


damage : Player -> Player
damage player =
    let
        newLifePoint =
            player.lifePoint - 1
    in
    { player | lifePoint = newLifePoint }


recovery : Player -> Player
recovery player =
    let
        newLifePoint =
            player.lifePoint + 1
    in
    { player | lifePoint = newLifePoint }


view : Model -> Html Msg
view model =
    div []
        [ div [ class "player" ]
            [ div [ class "player1" ]
                [ div [ class "plus-button", onClick DamagePlayer1 ] []
                , div [ class "life" ] [ text <| String.fromInt model.player1.lifePoint ]
                , div [ class "minus-button", onClick RecoveryPlayer1 ] []
                ]
            , div [ class "player2" ]
                [ div [ class "plus-button", onClick DamagePlayer2 ] []
                , div [ class "life" ] [ text <| String.fromInt model.player2.lifePoint ]
                , div [ class "minus-button", onClick RecoveryPlayer2 ] []
                ]
            ]
        , div [ class "reset-button", onClick Reset ]
            [ text "Reset" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
