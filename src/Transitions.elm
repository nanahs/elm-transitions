module Transitions exposing
    ( Transitions
    , make, view
    )

{-| transitions allows for optional msgs to be fired after the enter/leave transition has completed

@docs Transitions

@docs make, view

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Json.Decode as Decode
import Json.Encode as Encode


type Transitions msg
    = Transitions (Internals msg) (Html msg)


type alias Internals msg =
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


make : Internals msg -> Html msg -> Transitions msg
make =
    Transitions


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
