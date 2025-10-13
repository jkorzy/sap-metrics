  METHOD constructor.

    m_server_host = i_server_host.
    m_server_port = i_server_port.
    m_service = i_service.
    m_ref_handler = NEW #( ).
    TRY.
        m_ref_apc_client = cl_apc_tcp_client_manager=>create(
                         i_protocol               = 1   "2 for ssl
                         i_host                   = m_server_host
                         i_port                   = CONV string( m_server_port )
                         i_frame                  = VALUE #(
                            frame_type = if_apc_tcp_frame_types=>co_frame_type_terminator
                            terminator = `00`
                         )
                         i_event_handler          = m_ref_handler
*                     i_proxy                  =
*                     i_ssl_id                 =
                         i_do_not_use_client_cert = abap_true
                       ).
        m_ref_apc_client->connect( ).
      CATCH cx_apc_error INTO DATA(l_rcx_exception).
        RAISE EXCEPTION TYPE zjkt_cx_icap_exception
          EXPORTING
            previous = l_rcx_exception.
    ENDTRY.





  ENDMETHOD.