-module(foodchain_map_sup).

-behaviour(supervisor).

%% api
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(Id, Mod, Type, Timeout, Args), {Id, {Mod, start_link, Args}, permanent, Timeout, Type, [Mod]}).



%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    MaxLat = app_helper:get_env(foodchain, map_maxlat),
    MaxLong = app_helper:get_env(foodchain, map_maxlong),
    Lats = lists:seq(1, MaxLat),
    Longs = lists:seq(1, MaxLong),
    Maps = [fcutils_map:getName(Long, Lat) || Lat <- Lats, Long <- Longs],

    Childs = lists:map(fun(X) -> ?CHILD(X, foodchain_map, worker, 5000, [X]) end, Maps),
    io:format("~p~n", [Childs]),

    RestartStrategy = {one_for_one, 0, 1},
    {ok, { RestartStrategy, Childs} }.




