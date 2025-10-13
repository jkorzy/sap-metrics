  METHOD create_for_file.

    DATA l_file_content TYPE xstring.

    IF i_content_base64 IS NOT INITIAL.
      CALL FUNCTION 'SCMS_BASE64_DECODE_STR'
        EXPORTING
          input  = i_content_base64
*         unescape = 'X'
        IMPORTING
          output = l_file_content
        EXCEPTIONS
          failed = 1
          OTHERS = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
            INTO DATA(l_dummy).
        RAISE EXCEPTION TYPE zjkt_cx_icap_exception.
      ENDIF.
    ELSE.
      l_file_content = i_content_bin.
    ENDIF.

    CASE i_method.
      WHEN co_icap_method_respmod.
        r_instance = NEW zjkt_cl_icap_req_respmod(
          i_server_url  = i_server_url
          i_server_port = i_server_port
          i_service     = i_service
        ).
    ENDCASE.
    r_instance->create_request( i_content = l_file_content i_file_name = i_file_name ).

  ENDMETHOD.