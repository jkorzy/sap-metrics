  METHOD s_create.
    IF i_ref_factory IS BOUND.
      s_ref_factory = i_ref_factory.
    ENDIF.

    IF NOT s_ref_factory IS BOUND.
      s_ref_factory = NEW #( ).
    ENDIF.

    r_ref_factory = s_ref_factory.

  ENDMETHOD.