-module(foodchain_mainline_sup).
-behaviour(supervisor).

%% api
-export([start_link/0]).

%% call back
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
    MainLine = ?CHILD(mainline, worker),
    RestartStrategy = {one_for_one, 0, 1},
    {ok, { RestartStrategy, [MainLine]} }.



