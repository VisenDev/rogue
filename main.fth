include ansi.fth
include array.fth 
include rand.fth 

: let create , ;

40  constant width 
20  constant height
3   constant player-len-default

0   let ch
20  let player-x
10  let player-y
player-len-default
    let player-len
5   let cherry-x
5   let cherry-y

false value lost?

width height array-2d map
width height array-2d old-map

: ms-per-tick 100 ;

: move-cherry ( -- )
    rand width 2 - mod 1 + cherry-x !
    rand height 2 - mod 1 + cherry-y !
;

: cherry? ( x y -- n )
    cherry-y @ = swap
    cherry-x @ = and
;

: reset ( -- ) 
    width 0 do
        height 0 do
            0 j i map !
            0 j i old-map !
        loop
    loop
    width 2 / player-x !
    height 2 / player-y !
    player-len-default player-len !
    0 ch !
    false to lost? 
;

: edge? ( x y -- n )
    dup 0 <= 
    1 pick height 1- >= or
    2 pick 0 <= or
    2 pick width 1- >= or
    rot rot drop drop
;

: update-map ( -- ) 
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

: tail? ( x y -- n ) map @ 1 >= ;
: draw-map ( -- )
    0 0 goto
    height 0 do
        width 0 do
            \ j i goto
            i j edge? if
                s" #" type
            else
                i j cherry? if
                    s" @" type
                else
                    i j tail? if
                        s" c" type
                    else
                        s" ." type
                    then
                then
            then
        loop
        cr
    loop
;

: draw-debug ( -- )
    \ 0 2 height + goto
    cr
    ." player-x " player-x ? cr
    ." player-y " player-y ? cr
    ." player-len " player-len ? cr
    ." width " width . cr
    ." height " height . cr
    ." cherry-x" cherry-x ? cr
    ." cherry-y" cherry-y ? cr
;

: update-movement ( -- )
    ch @ case
        [char] j of 1 player-y +! endof
        [char] h of -1 player-x +! endof
        [char] k of -1 player-y +! endof
        [char] l of 1 player-x +! endof
    endcase

    ch @ 0 <>
    player-x @ player-y @ tail? and
    player-x @ player-y @ edge?
    or if
        true to lost?
    then

    player-x @ player-y @ cherry? if
        1 player-len +!
        move-cherry
    then
;

: record-input key? if key ch ! then ;
: quit? ch @ [char] q = ;

: draw-restart-menu ( -- )
    clear
    5 2 goto ." You Lost!"
    5 3 goto ." Score: " player-len ?
    5 4 goto ." Press [r] to restart " cr
;

: update-restart-menu ( -- )
    ch @ [char] r = if
        reset
        false to lost?
    then
;
 
: event-loop 
    clear
    move-cherry
    begin
        record-input

        lost? if
            update-restart-menu
            draw-restart-menu 
        else
            update-movement  
            update-map

            draw-map
            draw-debug
        then    

        ms-per-tick ms
    quit? until
    clear
    bye ;

event-loop
