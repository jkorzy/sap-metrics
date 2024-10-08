  METHOD get_instance.
    IF m_ref_instance IS NOT BOUND.
      m_ref_instance = NEW zjkt_cl_dao_metric_cus( ).
    ENDIF.
    r_ref_instance = m_ref_instance.
  ENDMETHOD.