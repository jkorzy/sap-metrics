CLASS ltcl_aunit DEFINITION FOR TESTING
    RISK LEVEL HARMLESS
    DURATION SHORT.

  PUBLIC SECTION.

    METHODS:
      not_icap_response FOR TESTING.
  PRIVATE SECTION.

    METHODS options_response FOR TESTING RAISING cx_static_check.
    METHODS respmod_response_with_virus FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_aunit IMPLEMENTATION.

  METHOD not_icap_response.
**********************************************************************
*Given Incorrect response
*Call constructor
*Expect NOT_ICAP_RESPONSE exception
**********************************************************************

    "HTTP Protocol instead of ICAP
    FINAL(wrong_response) =
           |HTTP/1.0 403 Forbidden\r\n|
        && |Server: C-ICAP\r\n|
        && |Connection: close\r\n|
        && |Content-Type: text/html\r\n|
        && |Content-Language: en\r\n|
        && |Via: ICAP/1.0 some.icap (C-ICAP/0.5.10 Antivirus service )|.
    FINAL(l_bin_response) =   cl_abap_conv_codepage=>create_out( )->convert( wrong_response ).


    TRY.
        "Try to instantiate zjkt_cl_icap_response end expect exception
        DATA(l_ref_response) = NEW zjkt_cl_icap_response( l_bin_response ).
        cl_abap_unit_assert=>fail( 'Expected exception not raised' ).
      CATCH zjkt_cx_icap_exception INTO DATA(l_rcx_exception).
        "Validate that correct textid was returned
        cl_abap_unit_assert=>assert_equals(
            msg = 'Wrong text_id in exception'
            exp = zjkt_cx_icap_exception=>not_icap_response
            act = l_rcx_exception->if_t100_message~t100key ).
    ENDTRY.

  ENDMETHOD.

  METHOD options_response.
**********************************************************************
*Given correct OPTIONS response
*Call constructor
*Expect class is instantiated
* and status is 200
**********************************************************************
    FINAL(options_response) =
        |ICAP/1.0 200 OK\r\n|
        && |Date: Mon, 10 Jan 2000  09:55:21 GMT\r\n|
        && |Methods: RESPMOD\r\n|
        && |Service: FOO Tech Server 1.0\r\n|
        && |ISTag: "W3E4R7U9-L2E4-2"\r\n|
        && |Encapsulated: null-body=0\r\n|
        && |Max-Connections: 1000\r\n|
        && |Options-TTL: 7200\r\n|
        && |Allow: 204\r\n|
        && |Preview: 2048\r\n|
        && |Transfer-Complete: asp, bat, exe, com\r\n|
        && |Transfer-Ignore: html\r\n|
        && |Transfer-Preview: *\r\n|.
    FINAL(l_bin_response) =   cl_abap_conv_codepage=>create_out( )->convert( options_response ).

    "Instantiate zjkt_cl_icap_response end expect exception
    DATA(l_ref_response) = NEW zjkt_cl_icap_response( l_bin_response ).

    cl_abap_unit_assert=>assert_bound( l_ref_response ).

    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect ICAP Status returned' exp = 200 act = l_ref_response->get_status( ) ).


  ENDMETHOD.


  METHOD respmod_response_with_virus.
**********************************************************************
*Given correct REPMOS response
*Call constructor
*Expect class is instantiated
* and ICAP status is 200
* and HTTP Status is 200
**********************************************************************
    FINAL(respomod_response) =
            |ICAP/1.0 200 OK\r\n|
        &&  |Server: C-ICAP/0.5.10\r\n|
        &&  |Connection: keep-alive\r\n|
        &&  |ISTag: "CI0001-WpTmWzgYHTWf6MQTTkvraAAA"\r\n|
        &&  |X-Infection-Found: Type=0; Resolution=2; Threat=Win.Test.EICAR_HDB-1;\r\n|
        &&  |X-Violations-Found: 1\r\n|
        &&  |   -\r\n|
        &&  |   Win.Test.EICAR_HDB-1\r\n|
        &&  |   0\r\n|
        &&  |   0\r\n|
        &&  |Encapsulated: res-hdr=0, res-body=180\r\n|
        &&  |\r\n|
        &&  |HTTP/1.0 403 Forbidden\r\n|
        &&  |Server: C-ICAP\r\n|
        &&  |Connection: close\r\n|
        &&  |Content-Type: text/html\r\n|
        &&  |Content-Language: en\r\n|
        &&  |Via: ICAP/1.0 kali.jk-technology.eu (C-ICAP/0.5.10 Antivirus service )\r\n|
        &&  |\r\n|
        &&  |60\r\n|
        &&  |<html>\r\n|
        &&  |<head>\r\n|
        &&  |   <title>VIRUS FOUND</title>\r\n|
        &&  |</head>\r\n|
        &&  |\r\n|
        &&  |<body>\r\n|
        &&  |<h1>VIRUS FOUND</h1>\r\n|
        &&  |</body>\r\n|.

    FINAL(l_bin_response) =   cl_abap_conv_codepage=>create_out( )->convert( respomod_response ).

    "Instantiate zjkt_cl_icap_response end expect exception
    DATA(l_ref_response) = NEW zjkt_cl_icap_response( l_bin_response ).

    cl_abap_unit_assert=>assert_bound( l_ref_response ).

    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect ICAP Status returned' exp = 200 act = l_ref_response->get_status( ) ).

    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect HTTP Status returned' exp = 403 act = l_ref_response->get_http_status( ) ).

  ENDMETHOD.



ENDCLASS.