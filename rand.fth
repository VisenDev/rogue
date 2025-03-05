variable rand-seed
7 rand-seed !

: rand    ( -- x )  \ return a 32-bit random number x
    rand-seed @
    dup 13 lshift xor
    dup 17 rshift xor
    dup 5  lshift xor
    dup rand-seed !
;

: setrand-seed   ( x -- )  \ rand-seed the RNG with x
    dup 0= or         \ map 0 to -1
    rand-seed !
;
