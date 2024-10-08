  METHOD zjkt_if_metrics~get_metrics.

    r_tab_metrics = VALUE #( FOR l_wrk_metric_cus IN zjkt_cl_daof_metric_cus=>s_create( )->get_instance( )->find_active_metrics( )
         LET l_tab_metric = get_metric( l_wrk_metric_cus )
         IN ( l_tab_metric ) ).

  ENDMETHOD.