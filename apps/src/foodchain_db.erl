-module(foodchain_db).
-behaviour(gen_server).

%% api
-export([start_link/0]).
-export([stop/0]).

%% call back
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-record(state, {}).


%% ===================================================================
%% API functions
%% ===================================================================
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

stop() ->
    gen_server:cast(?MODULE, stop).

%% ===================================================================
%% worker callbacks
%% ===================================================================
init([]) ->
    State = #state{},
    {ok, State}.


handle_call(_, _From, State) ->
    {reply, ok, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

%% @private
terminate(_Reason, _State) ->
    ok.

%% @private
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.




