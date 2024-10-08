  METHOD build_response.

    "Concatenate all metrics into one string
    DATA l_response_string TYPE string.
    DATA l_metric_string TYPE string.
    DATA l_separator TYPE string.

    l_separator = ''.

    LOOP AT i_tab_metrics ASSIGNING FIELD-SYMBOL(<l_wrk_metric>).
      l_metric_string = |# HELP { <l_wrk_metric>-name } { <l_wrk_metric>-description }|
       && cl_abap_char_utilities=>newline
       && |# TYPE { <l_wrk_metric>-name } | && COND string( WHEN <l_wrk_metric>-met_type EQ zjkt_if_dao_metric_cus=>con_metric_type_counter THEN 'counter' ELSE 'gauge' )
       && cl_abap_char_utilities=>newline
       && convert_values( i_metric_name = <l_wrk_metric>-name i_metric_values = <l_wrk_metric>-values ).
      l_response_string = |{ l_response_string }{ l_separator }{ l_metric_string }| && cl_abap_char_utilities=>newline.
    ENDLOOP.

    "Build response
    i_ref_server->response->set_content_type( 'text/plain' ).
    i_ref_server->response->set_cdata( l_response_string ).
    i_ref_server->response->set_status( EXPORTING code = 200 reason = 'OK' ).
  ENDMETHOD.