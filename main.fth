include ansi.fth

: array ( n "name" ) ( n -- addr )
    create cells allot
    does> swap cells + ;

0 variable ch
40 constant width
40 constant height

width height * constant cap
0 variable map-data cap cells allot
map-data cap cells 0 fill \ initialize map-data to 0
20 variable player-x
20 variable player-y
3 variable player-len

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
            i j map @ 0 > if
                -1 i j map !
            then
        loop
    loop

    10
    player-x @
    player-y @
    map !
;

: draw-arena ( -- )
    width 0 do
        height 0 do
            i 1+ j 1+ goto
            i j edge? if
                s" #" type
            then

            i j map @ 0> if
                s" @"
            else
                s" ." type
            then
       loop
   loop ;

 
: event-loop 
    cr
    begin
        clear
        record-player-tail
        draw-arena
        0 height 1+ goto
        s" ch is " type 4 color-fg ch @ emit color-reset
        key ch !
    ch @ [char] q = until
    clear
    bye ;

event-loop
