include ansi.fth

: array ( n "name" ) ( n -- addr )
    create cells allot
    does> swap cells + ;

: let ( n "name" -- )
    create ,
; 

40             constant width 
20             constant height
width height * constant cap

variable map-data cap cells allot
map-data cap cells 0 fill

0 let ch
20 let player-x
10 let player-y
10 let player-len

: edge? ( x y -- n )
    dup 0 <= 
    1 pick height 1- >= or
    2 pick 0 <= or
    2 pick width 1- >= or
    rot rot drop drop
;

: print-bool ( n -- )
    if ." true" cr else ." false" cr then ;

: player? ( x y -- n)
    player-y @ = 
    swap player-x @ =
    and ;

: map ( x y -- addr )
    height * + cells map-data +
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
   loop ;

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

 
: event-loop 
    cr
    begin
        clear
        record-player-tail
        draw-arena
        0 height 1+ goto
        s" ch is " type 4 color-fg ch @ emit color-reset
        draw-debug
        key ch !
        ch @ record-movement
    ch @ [char] q = until
    clear
    bye ;

event-loop
