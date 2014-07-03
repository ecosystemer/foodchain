-module(fcutils_common).

-export([sleep/1]).


sleep(Time) ->
    receive
        
    after Time ->
            true
    end.





