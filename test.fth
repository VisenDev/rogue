: array-dump ( addr len -- ) 0 do dup i cells + ? ." " loop cr ;
: array-zero ( addr len -- ) cells 0 fill ;
: array-2d-width ( addr - n ) ;
: array-2d-height ( addr - n ) 1 cells + ;
: array-2d-items ( addr - addr ) 2 cells + ;
: array-2d ( width height "name" -- ) ( x y -- addr)
    create 2dup 2dup * 2 + cells allot
        latestxt >body ~~ array-2d-height ! \ record height in cell 1
        latestxt >body array-2d-width ! \ record width in cell 0
        *
        latestxt >body array-2d-items
        swap array-zero \ zero items
    does> dup >r 
          array-2d-width @ * + cells r> array-2d-items + 
;

5 5 array-2d mem
2 2 mem ?
55 2 2 mem !
2 2 mem ? 
cr
