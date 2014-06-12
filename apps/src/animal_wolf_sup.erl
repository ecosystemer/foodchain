
-module(animal_wolf_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).
-export([die/1, born_cub/0]).

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
    Wolf = {animal_wolf, {animal_wolf, start_link, []}, temporary, brutal_kill, worker, [animal_wolf]},
    RestartStrategy = {simple_one_for_one, 0, 1},
    {ok, { RestartStrategy, [Wolf]} }.

%% 生仔
born_cub() ->
    supervisor:start_child(?MODULE, [animal_wolf]).

%% 死亡
die(Pid) ->
    supervisor:terminate_child(?MODULE, Pid).



