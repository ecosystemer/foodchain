-module(test_list).

-export([test/0]).

test() ->
    Lats = lists:seq(1, 3),
    Longs = lists:seq(1, 2),
    io:format("~p~n", [Lats]),
%    Maps = [X || Lat <- Lats, Long <- Longs, X = list_to_atom(integer_to_list(Lat) ++ "x" ++ integer_to_list(Long)) ],

    Maps = [ list_to_atom(integer_to_list(Lat) ++ "x" ++ integer_to_list(Long)) || Lat <- Lats, Long <- Longs],


    io:format("~p~n", [Maps]).
