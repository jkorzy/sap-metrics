  METHOD get_instance.
    IF i_ref_instance IS BOUND.
      m_ref_instance = i_ref_instance.
    ENDIF.
    IF m_ref_instance IS NOT BOUND.
      m_ref_instance = NEW zjkt_cl_metrics( ).
    ENDIF.
    r_ref_instance = m_ref_instance.
  ENDMETHOD.