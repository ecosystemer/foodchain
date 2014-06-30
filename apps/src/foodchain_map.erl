-module(foodchain_map).

-behaviour(gen_server).

-export([start_link/1]).

-export([stop/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-record(state, {
          animals,    % 在此区域的动物的列表: e.x. [wolf1, sheep2]
          other
         }).



start_link(Id) ->
    gen_server:start_link({local, Id}, ?MODULE, [], []).

stop() ->
    gen_server:cast(?MODULE, stop).

%% ===================================================================
%% worker callbacks
%% ===================================================================
init([]) ->
    State = #state{
      animals = []
     },
    {ok, State}.

handle_call(state, _From, State) ->   % 查询进程状态
    Reply = State,
    {reply, Reply, State};
handle_call(_, _From, State) ->
    {reply, ok, State}.

handle_cast({add, {Animal, Pid}}, State) ->  % Animal: wolf, sheep, grass
    Animals = State#state.animals,
    {noreply, State#state{
                animals = [{Animal, Pid} | Animals]
               }};
handle_cast(_, State) ->
    {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

%% @private
terminate(_Reason, _State) ->
    ok.

%% @private
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


