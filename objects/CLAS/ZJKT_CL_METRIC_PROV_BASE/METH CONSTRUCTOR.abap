  METHOD constructor.
    DATA(l_ref_metric_cust_dao) = zjkt_cl_daof_metric_cus=>s_create( )->get_instance( ).
    m_str_metric_cus = l_ref_metric_cust_dao->read( i_metric ).
  ENDMETHOD.