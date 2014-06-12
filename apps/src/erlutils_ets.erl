-module(erlutils_ets).

-export([insert/2, new/2]).



insert(Tab, Obj) ->
    ets:insert(Tab, Obj).

new(Name, _Options) ->
    ets:new(Name, []).







