\ returns the data ptr for the lastest word
: latest-data ( -- addr ) latestxt >body ;

: array ( n "name" ) ( n -- addr )
    create cells allot
    does> swap cells + ;
: array-dump ( addr len -- ) 0 do dup i cells + ? ." " loop cr ;
: array-zero ( addr len -- ) cells 0 fill ;

: array-2d-width ( addr - n ) ;
: array-2d-height ( addr - n ) 1 cells + ;
: array-2d-items ( addr - addr ) 2 cells + ;
: array-2d ( width height "name" -- ) ( x y -- addr)
    create 2dup 2dup * 3 + cells allot
        latest-data array-2d-height ! \ record height in cell 1
        latest-data array-2d-width ! \ record width in cell 0
        *
        latest-data array-2d-items
        swap array-zero \ zero items
    does> dup >r 
          array-2d-width @ * + cells r> array-2d-items + 
;


\  Testing
5 5 array-2d _mem
    assert( 2 2 _mem @ 0= )
    5 2 2 _mem ! 
    assert( 2 2 _mem 5 = )
    7 0 0 _mem !
    assert( 0 0 _mem 7 = )
    assert( 2 2 _mem 5 = )
    9 4 4 _mem !
    assert( 4 4 _mem 9 = )
    assert( 0 0 _mem 7 = )
    assert( 2 2 _mem 5 = )
