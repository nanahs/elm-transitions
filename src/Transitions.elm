module Transitions exposing
    ( transitions
    , view
    , withEnter
    , withEnterFrom
    , withEnterTo
    , withIsShowing
    , withLeave
    , withLeaveFrom
    , withLeaveTo
    , withOnEnter
    , withOnLeave
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Json.Decode as Decode
import Json.Encode as Encode



-- BUILDER PATTERN


type Transitions msg
    = Transitions
        { isShowing : Bool
        , enter : String
        , enterFrom : String
        , enterTo : String
        , onEnter : Maybe msg
        , leave : String
        , leaveFrom : String
        , leaveTo : String
        , onLeave : Maybe msg
        }
        (Html msg)


transitions : Html msg -> Transitions msg
transitions content =
    Transitions
        { isShowing = True
        , enter = ""
        , enterFrom = ""
        , enterTo = ""
        , onEnter = Nothing
        , leave = ""
        , leaveFrom = ""
        , leaveTo = ""
        , onLeave = Nothing
        }
        content


withIsShowing : Bool -> Transitions msg -> Transitions msg
withIsShowing isShowing (Transitions config content) =
    Transitions { config | isShowing = isShowing } content


withEnter : String -> Transitions msg -> Transitions msg
withEnter enter (Transitions config content) =
    Transitions { config | enter = enter } content


withEnterFrom : String -> Transitions msg -> Transitions msg
withEnterFrom enterFrom (Transitions config content) =
    Transitions { config | enterFrom = enterFrom } content


withEnterTo : String -> Transitions msg -> Transitions msg
withEnterTo enterTo (Transitions config content) =
    Transitions { config | enterTo = enterTo } content


withOnEnter : msg -> Transitions msg -> Transitions msg
withOnEnter onEnter (Transitions config content) =
    Transitions { config | onEnter = Just onEnter } content


withLeave : String -> Transitions msg -> Transitions msg
withLeave leave (Transitions config content) =
    Transitions { config | leave = leave } content


withLeaveFrom : String -> Transitions msg -> Transitions msg
withLeaveFrom leaveFrom (Transitions config content) =
    Transitions { config | leaveFrom = leaveFrom } content


withLeaveTo : String -> Transitions msg -> Transitions msg
withLeaveTo leaveTo (Transitions config content) =
    Transitions { config | leaveTo = leaveTo } content


withOnLeave : msg -> Transitions msg -> Transitions msg
withOnLeave onLeave (Transitions config content) =
    Transitions { config | onLeave = Just onLeave } content



-- VIEW


view : Transitions msg -> Html msg
view (Transitions config content) =
    Html.node "transitions-transitions"
        [ property "isShowing" (Encode.bool config.isShowing)
        , attribute "enter" config.enter
        , attribute "enter-from" config.enterFrom
        , attribute "enter-to" config.enterTo
        , attribute "leave" config.leave
        , attribute "leave-from" config.leaveFrom
        , attribute "leave-to" config.leaveTo
        , config.onEnter
            |> Maybe.map (Events.on "onEnter" << Decode.succeed)
            |> Maybe.withDefault (property "" Encode.null)
        , config.onLeave
            |> Maybe.map (Events.on "onLeave" << Decode.succeed)
            |> Maybe.withDefault (property "" Encode.null)
        ]
        [ content ]
