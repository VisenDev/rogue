: array ( n "name" ) ( n -- addr )
    create cells allot
    does> { n addr } n addr + ." n is " n . cr ;

100 array foo

5 5 foo !
5 foo @
