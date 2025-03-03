include ansi.fth

: array ( n "name" ) ( n -- addr )
    create cells allot
    does> + ;

 0 variable ch
 40 constant width
 40 constant height

: edge? ( x y -- n )
    dup 0 <= 
    1 pick height 1- >= or
    2 pick 0 <= or
    2 pick width 1- >= or
    rot rot drop drop
;

: print-bool ( n -- )
    if ." true" cr else ." false" cr then ;

 : draw-arena ( -- )
    width 0 do
        height 0 do
            i 1+ j 1+ goto
            i j edge? if
                s" #" type
            else
                s" ." type
            then
        loop
    loop ;
 
 : event-loop 
     cr
     begin
         clear
         draw-arena
         0 height 1+ goto
         s" ch is " type 4 color-fg ch @ emit color-reset
         key ch !
     ch @ [char] q = until
     clear
     bye ;
 
event-loop
