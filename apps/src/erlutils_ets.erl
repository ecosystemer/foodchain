-module(erlutils_ets).

-export([insert/2]).



insert(Tab, Obj) ->
    ets:insert(Tab, Obj).







