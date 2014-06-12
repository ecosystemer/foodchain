-module(foodchain_map).

-behaviour(gen_server).

-export([start_link/1]).

-export([stop/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-record(state, {}).



start_link(Id) ->
    gen_server:start_link({local, Id}, ?MODULE, [], []).

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

handle_cast({add, {wolf, Long, Lat}, Pid}, State) ->
    % @todo
    fc_utils_ets:add_animal(wolf, {Long, Lat}, Pid),
    {noreply, State};
handle_cast(_, State) ->
    {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

%% @private
terminate(_Reason, _State) ->
    ok.

%% @private
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


