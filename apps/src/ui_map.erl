-module(ui_map).


-compile(export_all).


getState() ->
    MaxLong = app_helper:get_env(foodchain, map_maxlong),
    MaxLat = app_helper:get_env(foodchain, map_maxlat),
    getState(MaxLong, MaxLat).
getState(Long, Lat) ->
    Name = fcutils_map:getName(Long, Lat),
    Rtn = gen_server:call(Name, state),
    io:format("~p~n", [Rtn]),
    ok.




