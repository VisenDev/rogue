include ansi.fth

: array ( n "name" ) ( n -- addr )
    create cells allot
    does> + ;


 0 variable ch
 40 constant width
 40 constant height
 
 : event-loop 
     cr
     begin
         clear
         s" ch is " type 4 color-fg ch @ emit color-reset
         key ch !
     ch @ [char] q = until
     bye ;
 
 event-loop
