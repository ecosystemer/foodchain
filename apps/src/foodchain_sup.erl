
-module(foodchain_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type, Timeout, Args), {I, {I, start_link, Args}, permanent, Timeout, Type, [I]}).
-define(CHILD(I, Type, Timeout), ?CHILD(I, Type, Timeout, [])).
-define(CHILD(I, Type), ?CHILD(I, Type, 5000)).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    Children = lists:flatten([
        ?CHILD(foodchain_db_sup, supervisor),
        ?CHILD(foodchain_map_sup, supervisor),
        ?CHILD(animal_wolf_sup, supervisor),
        ?CHILD(animal_sheep_sup, supervisor),
        ?CHILD(animal_grass_sup, supervisor),
        ?CHILD(foodchain_mainline_sup, supervisor)

    ]),
%    io:format("~p~n", [Children]),
    {ok, { {one_for_one, 5, 10}, Children} }.

