%% 
-module(foodchain_animal).
-behaviour(gen_server).

-export([start_link/0, stop/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,  
         terminate/2, code_change/3]).  

-record(state, {
          n_wolf,    % 已存在狼个数
          n_sheep,   % 已存在羊个数
          n_grass,   % 已存在草个数
          other
         }).


start_link()->
    State = #state{
      n_wolf = 0,
      n_sheep = 0,
      n_grass = 0
     },
    gen_server:start_link({local, ?MODULE}, ?MODULE, State, []).

stop() ->
    %% todo
    ok.

init(State) ->
    initWolf(),
    initSheep(),
    {ok, State}.  

initWolf() ->
    MaxWolf = app_helper:get_env(foodchain, wolf_initnum),
    Wolfs = lists:seq(1, MaxWolf),
    io:format("~p~n", [Wolfs]),
    Rtn = lists:map(
            fun(Wolf) -> 
                 supervisor:start_child(animal_wolf_sup, [Wolf])
            end, Wolfs
    ),
    io:format("~p~n", [Rtn]),
    ok.

initSheep() ->
    MaxSheep = app_helper:get_env(foodchain, sheep_initnum),
    Sheeps = lists:seq(1, MaxSheep),
    
    Rtn = lists:map(
            fun(Sheep) ->
                    supervisor:start_child(animal_sheep_sup, [Sheep])
            end, Sheeps
     ),
    io:format("~p~n", [Rtn]),
    ok.


handle_call(_Request, _From, State) ->  
    Reply = ok,  
    {reply, Reply, State}.  

handle_cast(_Msg, State) ->  
    {noreply, State}.  

handle_info(_Info, State) ->  
    {noreply, State}.  

terminate(_Reason, _State) ->  
    ok.  

code_change(_OldVsn, State, _Extra) ->  
    {ok, State}.

