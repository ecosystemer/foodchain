-module(animal_sheep).
-behaviour(gen_server).

-export([start_link/0, stop/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,  
         terminate/2, code_change/3]).  

-record(state, {age,    % 年龄
                hungry, % 饥饿度
                longitude, % 经度
                latitude,  % 纬度
                altitude,  % 高度(暂不用)
                other
               }).
-define(MAXLAT, 100).
-define(MAXLONG, 100).
-define(MAXAGE, 100).


start_link()->
    MaxLat = app_helper:get_env(foodchain, map_maxlat, ?MAXLAT),
    MaxLong = app_helper:get_env(foodchain, map_maxlong, ?MAXLONG),
    Long = util_random:get(MaxLong),
    Lat = util_random:get(MaxLat),
    gen_server:cast(foodchain_map, {add, {wolf, Long, Lat}, self()}),
    State = {state, 0, 0, Long, Lat, 0, 0},
    gen_server:start_link(?MODULE, State, []).

stop() ->
    %% todo
    ok.

init(State) ->
    {ok, State}.  

handle_call(_Request, _From, State) ->  
    Reply = ok,  
    {reply, Reply, State}.  

handle_cast(add_age, State) ->
    Age = State#state.age,
    MaxAge = app_helper:get_env(foodchain, wolf_maxage, ?MAXAGE),
    case Age > MaxAge of
        true ->
%            animal_wolf_sup:die(self()),
            io:format("i can still run after i die~n"),
            {stop, normal, State};
        false ->
            NewState = State#state{age = Age +1},
            {noreply, NewState}
    end;
handle_cast(_Msg, State) ->  
    {noreply, State}.  

handle_info(_Info, State) ->  
    {noreply, State}.  

terminate(_Reason, _State) ->  
    ok.  

code_change(_OldVsn, State, _Extra) ->  
    {ok, State}.

