  METHOD s_create.

    IF s_ref_factory IS NOT BOUND.
      IF i_ref_factory IS BOUND.
        s_ref_factory = i_ref_factory.
      ELSE.
        s_ref_factory = NEW #(  ).
      ENDIF.
    ENDIF.

    r_ref_factory = s_ref_factory.

  ENDMETHOD.