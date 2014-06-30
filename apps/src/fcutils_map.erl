-module(fcutils_map).

-export([getName/2]).



%% 根据经、纬度得到管理此区域的map的name
getName(Long, Lat) ->
    list_to_atom("map_" ++ integer_to_list(Long) ++ "x" ++ integer_to_list(Lat)).





