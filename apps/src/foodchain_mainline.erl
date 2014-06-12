-module(foodchain_mainline).
-behaviour(gen_server).

%% api
-export([start_link/0]).

%% call back
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% Helper macro for declaring children of supervisor
-define(CHILD(Id, Mod, Type, Timeout, Args), {Id, {Mod, start_link, Args}, permanent, Timeout, Type, [Mod]}).

-record(state, {}).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    %% 启动狼群
    State = #state{},
    {ok, State}.

handle_call(_Msg, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Msg, State) ->
    {noreply, State}.

terminate(_Reason, _State)->
    ok.

code_change(_Old, State, _Extra) ->
    {ok, State}.
