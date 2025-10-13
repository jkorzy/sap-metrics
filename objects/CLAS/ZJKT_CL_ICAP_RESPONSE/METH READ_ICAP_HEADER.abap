  METHOD read_icap_header.

    "Split response message to blocks:
    " - ICAP Header
    " - HTTP Header
    " - HTTP Body
    SPLIT i_icap_response AT co_block_delimiter  INTO TABLE DATA(l_tab_segments) IN BYTE MODE.

**********************************************************************
*ICAP Header
**********************************************************************
    "ICAP Header must be in first block
    "Convert first block to string and check if it starts with ICAP/1.0
    DATA(l_icap_header) = cl_abap_conv_codepage=>create_in( )->convert( l_tab_segments[ 1 ] ).

    IF strlen( l_icap_header ) < 15.
      RAISE EXCEPTION TYPE zjkt_cx_icap_exception
        EXPORTING
          textid = zjkt_cx_icap_exception=>not_icap_response.
    ENDIF.

    IF NOT l_icap_header(8) EQ 'ICAP/1.0'.
      RAISE EXCEPTION TYPE zjkt_cx_icap_exception
        EXPORTING
          textid = zjkt_cx_icap_exception=>not_icap_response.
    ENDIF.

    "Find ICAP Status
    FIND REGEX 'ICAP\/\d.\d (\d{3})' IN l_icap_header SUBMATCHES m_icap_header-status.

**********************************************************************
* HTTP Header
**********************************************************************

    "HTTP Header should be in second block, but is optional
    TRY.
        DATA(l_http_header) = cl_abap_conv_codepage=>create_in( )->convert( l_tab_segments[ 2 ] ).

        "Find HTTP Status
        FIND REGEX '^HTTP\/\d.\d (\d{3})' IN l_http_header SUBMATCHES m_http_header-status.

      CATCH cx_sy_itab_line_not_found.
        "do nothing
    ENDTRY.



  ENDMETHOD.