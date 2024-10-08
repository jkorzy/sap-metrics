CLASS ltd_http_request DEFINITION FOR TESTING.

  PUBLIC SECTION.
    INTERFACES if_http_request PARTIALLY IMPLEMENTED.
  PRIVATE SECTION.
    DATA: m_method TYPE string.

ENDCLASS.

CLASS ltd_http_request IMPLEMENTATION.

  METHOD if_http_request~set_method.
    m_method = method.
  ENDMETHOD.

  METHOD if_http_request~get_method.
    method = m_method.
  ENDMETHOD.

ENDCLASS.

**********************************************************************
* Test Double if_http_response
**********************************************************************

CLASS ltd_http_response DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES if_http_response PARTIALLY IMPLEMENTED.
  PRIVATE SECTION.
    DATA:
      m_status        TYPE i,
      m_reason        TYPE string,
      m_detailed_info TYPE string,
      m_content_type  TYPE string,
      m_body          TYPE string.
ENDCLASS.

CLASS ltd_http_response IMPLEMENTATION.


  METHOD if_http_response~set_status.
    m_status = code.
    m_reason = reason.
    m_detailed_info = detailed_info.
  ENDMETHOD.

  METHOD if_http_response~get_status.
    code = m_status.
    reason = m_reason.
  ENDMETHOD.

  METHOD if_http_response~set_content_type.
    m_content_type = content_type.
  ENDMETHOD.

  METHOD if_http_response~get_content_type.
    content_type = m_content_type.
  ENDMETHOD.

  METHOD if_http_response~set_cdata.
    m_body = data.
  ENDMETHOD.

  METHOD if_http_response~get_cdata.
    data = m_body.
  ENDMETHOD.


ENDCLASS.


**********************************************************************
* Test Double http server
**********************************************************************

CLASS ltd_http_server DEFINITION FOR TESTING.

  PUBLIC SECTION.
    INTERFACES if_http_server PARTIALLY IMPLEMENTED.
    METHODS constructor.
ENDCLASS.

CLASS ltd_http_server IMPLEMENTATION.
  METHOD constructor.
    if_http_server~request = NEW ltd_http_request( ).
    if_http_server~response = NEW ltd_http_response( ).
  ENDMETHOD.


ENDCLASS.

**********************************************************************
* Test Double zjkt_if_metrics
**********************************************************************
CLASS ltd_metrics DEFINITION FOR TESTING.

  PUBLIC SECTION.
    INTERFACES zjkt_if_metrics PARTIALLY IMPLEMENTED.

    METHODS set_exception.
  PRIVATE SECTION.
    DATA m_flg_exception TYPE xfeld.

ENDCLASS.

CLASS ltd_metrics IMPLEMENTATION.

  METHOD zjkt_if_metrics~get_metrics.
    IF m_flg_exception IS INITIAL.
      r_tab_metrics = VALUE zjkt_if_metrics=>tt_metrics(
        (
          description = 'Metric 1 Unit Test'
          name = 'test_metric_1'
          met_type = zjkt_if_dao_metric_cus=>con_metric_type_counter
          values = value #(
            (
                labels = value #( ( name = 'label1' value = 'test11' ) ( name = 'label2' value = 'test12' ) )
                value = '1.744'
            )
            (
                labels = value #( ( name = 'label1' value = 'test21' ) ( name = 'label2' value = 'test22' ) )
                value = '5.744'
            )

          )
         )
         (
           description = 'Metric 2 Unit Test'
           name = 'test_metric_2'
           met_type = zjkt_if_dao_metric_cus=>con_metric_type_gauge
           values = value #( ( value = '9.737' ) )
         )
        ).
    ELSE.
      MESSAGE e000(zjkt_metrics_dal) WITH 'TEST' INTO DATA(l_msg).
      zjkt_cx_metrics_exception=>raise( ).
    ENDIF.
  ENDMETHOD.

  METHOD set_exception.
    m_flg_exception = abap_true.
  ENDMETHOD.

ENDCLASS.


**********************************************************************
* Test Class
**********************************************************************

CLASS ltcl_unit DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      m_ref_cut    TYPE REF TO zjkt_cl_metric_http_handler,
      m_ref_server TYPE REF TO if_http_server.

    METHODS:
      setup,
      get_metrics FOR TESTING RAISING cx_static_check,
      incorrect_http_method FOR TESTING RAISING cx_static_check,
      exception_handling FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_unit IMPLEMENTATION.

  METHOD setup.
    m_ref_cut = NEW #( ).
    m_ref_server = NEW ltd_http_server( ).

    "Set test double for zjkt_if_metrics
    zjkt_cl_metrics_fact=>s_create( )->get_instance( NEW ltd_metrics( ) ).

  ENDMETHOD.

  METHOD get_metrics.

    m_ref_server->request->set_method( if_http_request=>co_request_method_get ).
    m_ref_cut->if_http_extension~handle_request( m_ref_server ).

    DATA l_expected TYPE TABLE OF string.
    l_expected = VALUE #( ( |# HELP test_metric_1 Metric 1 Unit Test| )
                          ( |# TYPE test_metric_1 counter| )
                          ( |test_metric_1\{label1="test11",label2="test12"\} 1.744| )
                          ( |test_metric_1\{label1="test21",label2="test22"\} 5.744| )
                          ( |# HELP test_metric_2 Metric 2 Unit Test| )
                          ( |# TYPE test_metric_2 gauge| )
                          ( |test_metric_2 9.737| && cl_abap_char_utilities=>newline ) ).

    DATA l_expected_string TYPE string.
    CONCATENATE LINES OF l_expected INTO l_expected_string SEPARATED BY cl_abap_char_utilities=>newline.

    cl_abap_unit_assert=>assert_equals( msg = 'Wrong content type' exp = 'text/plain' act = m_ref_server->response->get_content_type( ) ).

    data(l_metric_string) = m_ref_server->response->get_cdata( ).
    cl_abap_unit_assert=>assert_equals( msg = 'Wrong metric' exp = l_expected_string act = m_ref_server->response->get_cdata( ) ).



  ENDMETHOD.

  METHOD incorrect_http_method.

    m_ref_server->request->set_method( if_http_request=>co_request_method_post ).


    m_ref_cut->if_http_extension~handle_request( m_ref_server ).

    m_ref_server->response->get_status(
       IMPORTING
           code = DATA(l_code)
           reason = DATA(l_reason)
    ).

    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect response code' exp = 405 act = l_code ).
    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect response reasom' exp = 'Method not allowed' act = l_reason ).

  ENDMETHOD.

  METHOD exception_handling.

    cast ltd_metrics( zjkt_cl_metrics_fact=>s_create( )->get_instance( ) )->set_exception( ).
    m_ref_server->request->set_method( if_http_request=>co_request_method_get ).

    m_ref_cut->if_http_extension~handle_request( m_ref_server ).

    m_ref_server->response->get_status(
       IMPORTING
           code = DATA(l_code)
           reason = DATA(l_reason)
    ).

    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect response code' exp = 500 act = l_code ).
    cl_abap_unit_assert=>assert_equals( msg = 'Incorrect response reasom' exp = '&TEST&' act = l_reason ).

  ENDMETHOD.

ENDCLASS.