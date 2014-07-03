-module(foodchain_mainline).
-behaviour(gen_server).

%% api
-export([start_link/0]).

%% call back
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% Helper macro for declaring children of supervisor
-define(CHILD(Id, Mod, Type, Timeout, Args), {Id, {Mod, start_link, Args}, permanent, Timeout, Type, [Mod]}).

-record(state, {}).

-define(TIMER_INTERVAL, 2).%%循环间隔的秒数


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    %% 主进程控制
    {ok, TRef} = timer:send_interval(timer:seconds(?TIMER_INTERVAL), do_the_staff),

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



%%%
%%% 1. 判断前一行动是否已经做完
%%% 2. 开始下一行动
%%%
do_the_staff() ->
    if last_work_finished() ->
            do_next_work();
       true ->
            fcutils_common:sleep(1)
    end.

% 判断前一行动是否已经做完
last_work_finished() ->
    true.

% 通知进行下一步工作
do_next_work() ->
    % todo
    
