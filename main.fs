: type ( addr c -- )
    stdout write-file 0 <> if
        ." ERROR" bye
    then ;
: emit ( n -- )
    stdout emit-file 0 <> if
        ." ERROR" bye
    then ;
: cr 10 emit ;
: to-string ( n -- addr c )  s>d <# #s #> ;
: ascii-esc 27 emit ;
: esc ascii-esc s" [" type ;
: char-; [char] ; emit ;
: char-H [char] H emit ;
: type-num ( n -- ) to-string type ;
: goto ( x y -- ) esc type-num char-; type-num char-H ;
: clear-from-cursor esc s" 2J" type ;
: clear 0 0 goto clear-from-cursor ;
: color-fg ( n -- ) esc s" 38;5;" type type-num s" m" type ;
: color-bg ( n -- ) esc s" 48;5;" type type-num s" m" type ;
: color-reset esc s" 0m" type ;
: cursor-on esc s" ?25l" type ;
: cursor-off esc s" ?25h" type ;
0 variable ch
0 variable old-ch
: event-loop 
    cr
    begin
        clear
        ch @ old-ch @ <> if
            s" ch is " type 4 color-fg ch @ type-num cr color-reset
        then
        ch @ old-ch !
        key ch !
    ch @ [char] q = until
    bye ;

event-loop
