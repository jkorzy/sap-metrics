  METHOD build_file_body.


    "Get file size converted to HEX and then to xstring
    final(l_file_size_hex) = cl_abap_conv_codepage=>create_out( )->convert( conv2hex( xstrlen( i_content ) ) ).


    DATA l_body TYPE xstring.

    CONCATENATE l_file_size_hex co_eol i_content co_eol INTO l_body IN BYTE MODE.

    APPEND l_body TO m_tab_request.

  ENDMETHOD.