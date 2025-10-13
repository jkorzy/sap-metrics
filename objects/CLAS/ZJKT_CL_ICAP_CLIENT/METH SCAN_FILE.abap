  METHOD scan_file.

    FINAL(l_ref_request) = zjkt_cl_icap_request=>create_for_file(
                             i_method         =  zjkt_cl_icap_request=>co_icap_method_respmod
                             i_server_url     = m_server_host
                             i_server_port    = m_server_port
                             i_service        = m_service
*                             i_content_base64 =
                             i_content_bin    =  i_file_content
                             i_file_name      = i_file_name
                           ).


    CONCATENATE LINES OF l_ref_request->get_request( ) INTO DATA(l_bin_message) IN BYTE MODE.

    FINAL(l_terminator) = CONV xstring( `00` ).
    CONCATENATE l_bin_message l_terminator INTO l_bin_message IN BYTE MODE.


    TRY.
        send_message( l_bin_message ).
      CATCH cx_apc_error INTO DATA(l_rcx_error).
        WRITE l_rcx_error->get_text( ).
    ENDTRY.

    WAIT FOR PUSH CHANNELS
         UNTIL m_ref_handler->m_ref_icap_response IS BOUND
         UP TO 10 SECONDS.



    WRITE:
        /'Koniec: ',
        /'ICAP Status: ', m_ref_handler->m_ref_icap_response->get_status( ),
        /'HTTP Status: ', m_ref_handler->m_ref_icap_response->get_http_status( ).

  ENDMETHOD.