  METHOD conv2hex.

    FINAL(l_hex) = CONV xstring( i_number ).
    r_hex = CONV string( l_hex ).

  ENDMETHOD.