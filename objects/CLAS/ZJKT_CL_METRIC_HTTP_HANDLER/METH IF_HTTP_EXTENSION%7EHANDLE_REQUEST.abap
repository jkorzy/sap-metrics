  METHOD if_http_extension~handle_request.

    TRY.
        "Only GET Method is supported
        IF server->request->get_method( ) EQ if_http_request=>co_request_method_get.
          "Build metrics
          DATA(l_ref_metrics) = zjkt_cl_metrics_fact=>s_create( )->get_instance( ).
          DATA(l_tab_metrics) = l_ref_metrics->get_metrics( ).
          "Prepare responose
          build_response( i_ref_server = server i_tab_metrics = l_tab_metrics ).
        ELSE.
          "If HTTP Method is not GET then return 405 error
          build_error_response( i_ref_server = server i_status = 405 i_message = 'Method not allowed' ).
        ENDIF.
      CATCH zjkt_cx_metrics_exception INTO DATA(l_rcx_metrics).
        "In case of error return error response
        build_error_response( i_ref_server = server i_ref_exception = l_rcx_metrics ).
      CATCH cx_root INTO DATA(l_rcx_root).
        "If unknown error occurred return generic error
        build_error_response( i_ref_server = server i_status = 500 i_message = 'Internal server error').
    ENDTRY.



  ENDMETHOD.