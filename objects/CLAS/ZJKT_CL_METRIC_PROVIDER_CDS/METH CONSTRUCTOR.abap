  METHOD constructor.
    super->constructor( i_metric ).

    cl_dd_ddl_utilities=>is_cds_view(
        EXPORTING
            name = CONV #( m_str_metric_cus-prov_name )
        IMPORTING
            is_cds_view = DATA(l_exists)
    ).

    IF l_exists EQ abap_true.
      m_cds_name = m_str_metric_cus-prov_name.
    ELSE.
      MESSAGE e001(zjkt_metrics_prov) WITH m_str_metric_cus-prov_name INTO DATA(l_dummy).
      zjkt_cx_metrics_exception=>raise( ).
    ENDIF.

  ENDMETHOD.