CLASS ltcl_aunit DEFINITION FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.

  PUBLIC SECTION.

    METHODS create_respmod_req FOR TESTING.

  PRIVATE SECTION.
    "File content is: This is data that was returned by an origin server..
    CONSTANTS: file_base64 TYPE string VALUE 'VGhpcyBpcyBkYXRhIHRoYXQgd2FzIHJldHVybmVkIGJ5IGFuIG9yaWdpbiBzZXJ2ZXIu'.


ENDCLASS.


CLASS ltcl_aunit IMPLEMENTATION.

  METHOD create_respmod_req.

    FINAL(l_expected_headers) =
           |RESPMOD icap://icap.unittest:3144/avscan ICAP/1.0\r\n|
        && |Host: icap.unittest\r\n|
        && |User-Agent: SAP ICAP Client/1.1\r\n|
        && |Keep-Alive: timeout=5, max=200\r\n|
        && |Allow: 204\r\n|
        && |Encapsulated: req-hdr=0, res-hdr=47, res-body=114\r\n|
        && |\r\n|
        && |GET /test.txt HTTP/1.1\r\n|
        && |Host: icap.unittest\r\n|
        && |\r\n|
        && |HTTP/1.1 200 OK\r\n|
        && |Transfer-Encoding: chunked\r\n|
        && |Content-Length: 51\r\n\r\n|.
    FINAL(l_expected_headers_bin) = cl_abap_conv_codepage=>create_out( )->convert( l_expected_headers ).

    FINAL(l_expected_body) =
            |33\r\n|
         && |This is data that was returned by an origin server.\r\n|.
    FINAL(l_expected_body_bin) = cl_abap_conv_codepage=>create_out( )->convert( l_expected_body ).

    FINAL(l_ref_cut) = zjkt_cl_icap_request=>create_for_file(
                        i_method         = zjkt_cl_icap_request=>co_icap_method_respmod
                        i_server_url     = 'icap.unittest'
                        i_server_port    = '3144'
                        i_service        = 'avscan'
                        i_content_base64 = file_base64
                        i_file_name      = 'test.txt'
                      ).

    FINAL(l_tab_request) = l_ref_cut->get_request( ).

    "Check Headers block
    DATA(l_block) = cl_abap_conv_codepage=>create_in( )->convert( l_tab_request[ 1 ] ).
    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect headers in ICAP Request'
                                        exp = l_expected_headers_bin
                                        act = l_tab_request[ 1 ] ).

    "Check file body
    l_block = cl_abap_conv_codepage=>create_in( )->convert( l_tab_request[ 2 ] ).
    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect body in ICAP Request'
                                        exp = l_expected_body_bin
                                        act = l_tab_request[ 2 ] ).

    "Check end of line
    l_block = cl_abap_conv_codepage=>create_in( )->convert( l_tab_request[ 3 ] ).
    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect eof in ICAP Request'
                                        exp = zjkt_cl_icap_request=>co_eof
                                        act = l_tab_request[ 3 ] ).


  ENDMETHOD.

ENDCLASS.