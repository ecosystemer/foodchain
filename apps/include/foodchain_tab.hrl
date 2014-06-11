-record(tab_map, {
          position,  % 位置{long, lat, alt}
          animal,    % wolf, sheep, grass
          pid
          
                 }).

-record(tab_animal, {
          pid
         }).


-record(tab_wolf, {
          pid,
          age,
          hungry,
          longtitude,
          latitude,
          altitude,
          other
         }).



