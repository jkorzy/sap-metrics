  METHOD get_metric.

    DATA(l_ref_provider) = zjkt_cl_metric_prov_factory=>s_create( )->get_instance( i_str_metr_cus-metric ).


    r_metric = VALUE #(
        name = l_ref_provider->get_metric_name( )
        description = l_ref_provider->get_metric_decription( )
        met_type = l_ref_provider->get_metric_type( )
        values = l_ref_provider->get_metric_values(  )
    ).


  ENDMETHOD.