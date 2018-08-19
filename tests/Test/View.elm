module Test.View exposing (..)

import Date
import Date.Extra as Date
import Expect exposing (all)
import Html.Attributes exposing (value)
import Init exposing (init)
import Model exposing (Asset, Interest, Model)
import Test exposing (Test, describe, test)
import Test.Html.Query exposing (find, findAll, fromHtml, has, index)
import Test.Html.Selector exposing (attribute, id, tag, text)
import Tuple exposing (first)
import View exposing (view)


model0 : Model
model0 =
    first init


oie : Test
oie =
    test "shows oie on the screen" <|
        \() ->
            view model0
                |> fromHtml
                |> has [ text "oie" ]


interestsTable : Test
interestsTable =
    let
        table =
            { model0 | interests = [ Interest (Date.fromCalendarDate 2018 Date.Jan 11) 1.2 ] }
                |> view
                |> fromHtml
                |> find [ id "interests-table" ]
    in
    describe "interests table"
        [ test "shows header with proper column names" <|
            \() ->
                table
                    |> find [ tag "thead" ]
                    |> all
                        [ has [ text "Date" ]
                        , has [ text "Rate" ]
                        ]
        , test "shows properly formatted interest on the body" <|
            \() ->
                table
                    |> find [ tag "tbody" ]
                    |> all
                        [ has [ text "120.00%" ]
                        , has [ text "2018-01-11" ]
                        ]
        ]


interestForm : Test
interestForm =
    let
        form =
            view { model0 | interestFormDate = "some-date", interestFormRate = "some-rate" }
                |> fromHtml
                |> find [ id "interest-form" ]
    in
    describe "interest form"
        [ test "shows the date input with value from model" <|
            \() ->
                form
                    |> findAll [ tag "input" ]
                    |> index 0
                    |> has [ attribute (value "some-date") ]
        , test "shows the rate input with value from model" <|
            \() ->
                form
                    |> findAll [ tag "input" ]
                    |> index 1
                    |> has [ attribute (value "some-rate") ]
        , test "shows submit button" <|
            \() ->
                form
                    |> find [ tag "button" ]
                    |> has [ text "Add" ]
        ]


assetsTable : Test
assetsTable =
    let
        table =
            { model0 | assets = [ Asset (Date.fromCalendarDate 2018 Date.Jan 11) 1234.56 7.8 ] }
                |> view
                |> fromHtml
                |> find [ id "assets-table" ]
    in
    describe "assets table"
        [ test "shows header with proper column names" <|
            \() ->
                table
                    |> find [ tag "thead" ]
                    |> all
                        [ has [ text "Maturity" ]
                        , has [ text "Amount" ]
                        , has [ text "Yield" ]
                        ]
        , test "shows properly formatted interest on the body" <|
            \() ->
                table
                    |> find [ tag "tbody" ]
                    |> all
                        [ has [ text "2018-01-11" ]
                        , has [ text "1,234.56" ]
                        , has [ text "780.00%" ]
                        ]
        ]


assetForm : Test
assetForm =
    let
        form =
            view
                { model0
                    | assetFormMaturity = "some-maturity"
                    , assetFormAmount = "some-amount"
                    , assetFormYield = "some-yield"
                }
                |> fromHtml
                |> find [ id "asset-form" ]
    in
    describe "asset form"
        [ test "shows the maturity input with value from model" <|
            \() ->
                form
                    |> findAll [ tag "input" ]
                    |> index 0
                    |> has [ attribute (value "some-maturity") ]
        , test "shows the amount input with value from model" <|
            \() ->
                form
                    |> findAll [ tag "input" ]
                    |> index 1
                    |> has [ attribute (value "some-amount") ]
        , test "shows the yield input with value from model" <|
            \() ->
                form
                    |> findAll [ tag "input" ]
                    |> index 2
                    |> has [ attribute (value "some-yield") ]
        , test "shows submit button" <|
            \() ->
                form
                    |> find [ tag "button" ]
                    |> has [ text "Add" ]
        ]
