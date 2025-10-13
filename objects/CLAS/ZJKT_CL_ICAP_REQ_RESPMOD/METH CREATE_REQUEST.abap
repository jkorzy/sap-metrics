  METHOD create_request.
    FINAL(l_file_size) = xstrlen( i_content ).

    FINAL(lv_res_header) = |GET /{ i_file_name } HTTP/1.1\r\n|
        && |Host: { m_server_host }\r\n\r\n|.

    FINAL(lv_res_header_length) = strlen( lv_res_header ).

    FINAL(lv_res_body) =
           lv_res_header
        && |HTTP/1.1 200 OK\r\n|
*        && |Transfer-Encoding: chunked\r\n|
        && |Content-Length: { l_file_size }\r\n\r\n|.

    FINAL(lv_res_body_length) = strlen( lv_res_body ).

    FINAL(l_headers) = |RESPMOD icap://{ m_server_url }/{ m_service } ICAP/1.0\r\n|
      && |Host: { m_server_host }\r\n|
      && |User-Agent: SAP ICAP Client/1.1\r\n|
      && |Keep-Alive: timeout=5, max=200\r\n|
      && |Allow: 204\r\n|
*      && |Preview: { l_file_size } \r\n|
      && |Encapsulated: req-hdr=0, res-hdr={ lv_res_header_length }, res-body={ lv_res_body_length }\r\n|
      && |\r\n|
      && lv_res_body.

    FINAL(l_bin_headers) =
          cl_abap_conv_codepage=>create_out( )->convert( l_headers ).

    APPEND l_bin_headers TO m_tab_request.
    build_file_body( i_content ).
    APPEND co_eof TO m_tab_request.

  ENDMETHOD.