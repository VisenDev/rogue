include ansi.fth
include array.fth 

: let create , ;

40 constant width 
20 constant height
   width height *
   constant cap

0  let ch
20 let player-x
10 let player-y
10 let player-len

false value lost

width height array-2d map
width height array-2d old-map

: edge? ( x y -- n )
    dup 0 <= 
    1 pick height 1- >= or
    2 pick 0 <= or
    2 pick width 1- >= or
    rot rot drop drop
;

: record-player-tail ( -- ) 
    width 0 do
        height 0 do
            j i map @ 0 > if
                -1 j i map +!
            then
        loop
    loop

    player-len @ 
    player-x @
    player-y @
    map !
;

: draw-arena ( -- )
    width 0 do
        height 0 do
            j 1+ i 1+ goto
            j i edge? if
                s" #" type
            else
                j i map @ 1 >= if
                    s" @" type
                else
                    s" ." type
                then
            then
        loop
    loop
    0 height 1+ goto
;

: draw-debug ( -- )
    0 2 height + goto
    ." player-x " player-x ? cr
    ." player-y " player-y ? cr
    ." player-len " player-len ? cr
;

: record-movement ( ch -- )
    case
        [char] j of 1 player-y +! endof
        [char] h of -1 player-x +! endof
        [char] k of -1 player-y +! endof
        [char] l of 1 player-x +! endof
    endcase
;

: record-input key? if key ch ! else 100 ms then ;
: quit? ch @ [char] q = ;
 
: event-loop 
    clear
    begin
        record-player-tail
        draw-arena
        draw-debug
        record-input
        ch @ record-movement
    quit? until
    clear
    bye ;

event-loop
