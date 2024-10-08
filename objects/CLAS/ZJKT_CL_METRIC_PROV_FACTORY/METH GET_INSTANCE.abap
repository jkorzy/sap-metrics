  METHOD get_instance.
    DATA(l_str_metric_cus) = zjkt_cl_daof_metric_cus=>s_create( )->get_instance( )->read( i_metric ).

    IF l_str_metric_cus-prov_type = zjkt_if_dao_metric_cus=>con_met_provider_class.
      CREATE OBJECT r_ref_instance
      TYPE (l_str_metric_cus-prov_name).
    ELSE.
      r_ref_instance = NEW zjkt_cl_metric_provider_cds( i_metric = i_metric ).
    ENDIF.

  ENDMETHOD.