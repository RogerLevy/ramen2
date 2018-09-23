\ [ ] overflow checking

: stack  0 ,  cells /allot ;
: #pushed  @ ;
: truncate  ( stk newsize -- )  swap ! ;
: pop  ( stk -- val )
    >r  r@ @ 0= abort" ERROR: Stack object underflow." r@ dup @ cells + @  -1 r> +! ;
: push  ( val stk -- )  >r  1 r@ +!   r> dup @ cells + !  ;
: pushes  ( ... stk n -- ) swap locals| s |  0 ?do  s push  loop ;
: pops    ( stk n -- ... ) swap locals| s |  0 ?do  s pop  loop ;
: scount  ( stk -- addr count ) @+  ;
: sbounds  ( stk -- end start ) scount cells over + swap ;
: []  ( stk n -- addr )  pfloor 1 + cells + ;
: nth ( n stk -- addr )   swap pfloor [] ;

\ TABLE: ( -- <name> adr ) create an array you can comma data into
\ ;TABLE ( adr -- ) call to terminate the definition
: table:  create here 0 , ;
: ;table  here over - cell/ 1p 1 - swap ! ;
