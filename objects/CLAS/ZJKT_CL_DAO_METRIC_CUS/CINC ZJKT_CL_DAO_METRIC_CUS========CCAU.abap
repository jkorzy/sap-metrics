CLASS ltcl_aunit DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA: s_ref_environment TYPE REF TO if_osql_test_environment .
    CLASS-METHODS class_setup.
    METHODS:
      setup,
      teardown,
      "! Test that only active metrics are returned
      "! @raising cx_static_check | Exception
      active_rows FOR TESTING RAISING cx_static_check,

      "! Test empty list returned when there are no active metrics
      "! @raising cx_static_check | Exception
      find_active_from_empty FOR TESTING RAISING cx_static_check,


      "!Test read metric customizing by key, check that record is returned
      "! @raising cx_static_check | Exception
      read FOR TESTING RAISING cx_static_check,

      "!Test read metric customizing by not existing key, check that exception is thrown
      "! @raising cx_static_check | Exception
      read_not_existing FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_aunit IMPLEMENTATION.

  METHOD class_setup.
    s_ref_environment = cl_osql_test_environment=>create( VALUE #( ( 'ZJKT_METRIC_CUS' ) ) ).
  ENDMETHOD.

  METHOD setup.
    DATA l_tab_data TYPE TABLE OF zjkt_metric_cus.
    l_tab_data = VALUE #( ( client = sy-mandt metric = '001'
                            met_type = zjkt_if_dao_metric_cus=>con_metric_type_counter
                            description = 'Test Metric'
                            name = 'test.metric'
                            prov_type = zjkt_if_dao_metric_cus=>con_met_provider_class
                            prov_name = 'ZCL_TEST_METRIC'
                            active = abap_true
                           )
                           ( client = sy-mandt metric = '002'
                            met_type = zjkt_if_dao_metric_cus=>con_metric_type_counter
                            description = 'Test Metric inactive'
                            name = 'test.metric.inact'
                            prov_type = zjkt_if_dao_metric_cus=>con_met_provider_class
                            prov_name = 'ZCL_TEST_METRIC'
                            active = abap_false

                           )
                         ).
    s_ref_environment->insert_test_data( l_tab_data ).
  ENDMETHOD.

  METHOD teardown.
    s_ref_environment->clear_doubles( ).
  ENDMETHOD.

  METHOD active_rows.

    DATA(l_ref_cut) = NEW zjkt_cl_dao_metric_cus( ).
    DATA(l_tab_metrics) = l_ref_cut->zjkt_if_dao_metric_cus~find_active_metrics( ).

    cl_abap_unit_assert=>assert_equals( exp = 1 act = lines( l_tab_metrics ) ).

    cl_abap_unit_assert=>assert_equals(
        msg = 'Found actvie metric is wrong'
        exp = VALUE zjkt_metric_cus(  client = sy-mandt metric = '001'
                            met_type = zjkt_if_dao_metric_cus=>con_metric_type_counter
                            description = 'Test Metric'
                            name = 'test.metric'
                            prov_type = zjkt_if_dao_metric_cus=>con_met_provider_class
                            prov_name = 'ZCL_TEST_METRIC'
                            active = abap_true )
        act = l_tab_metrics[ 1 ] ).

  ENDMETHOD.

  METHOD find_active_from_empty.

    s_ref_environment->clear_doubles( ).

    DATA(l_ref_cut) = NEW zjkt_cl_dao_metric_cus( ).
    DATA(l_tab_metrics) = l_ref_cut->zjkt_if_dao_metric_cus~find_active_metrics( ).

    cl_abap_unit_assert=>assert_equals( exp = 0 act = lines( l_tab_metrics ) ).

  ENDMETHOD.

  METHOD read.

    DATA(l_ref_cut) = NEW zjkt_cl_dao_metric_cus( ).
    DATA(l_str_metric) = l_ref_cut->zjkt_if_dao_metric_cus~read( '001' ).

    cl_abap_unit_assert=>assert_equals(
        msg = 'Check read metric customizing'
        exp = VALUE zjkt_metric_cus(  client = sy-mandt metric = '001'
                            met_type = zjkt_if_dao_metric_cus=>con_metric_type_counter
                            description = 'Test Metric'
                            name = 'test.metric'
                            prov_type = zjkt_if_dao_metric_cus=>con_met_provider_class
                            prov_name = 'ZCL_TEST_METRIC'
                            active = abap_true )
        act = l_str_metric ).

  ENDMETHOD.

  METHOD read_not_existing.


    DATA(l_ref_cut) = NEW zjkt_cl_dao_metric_cus( ).
    TRY.
        DATA(l_str_metric) = l_ref_cut->zjkt_if_dao_metric_cus~read( 'NEX' ).
        cl_abap_unit_assert=>fail(
           msg    = 'Read not exsting: expected Exception not thrown'
        ).
      CATCH zjkt_cx_metrics_exception INTO DATA(l_ref_exception).
        cl_abap_unit_assert=>assert_equals(
            msg = 'Incorrect message'
            exp = VALUE scx_t100key( msgid = 'ZJKT_METRICS_DAL' msgno = '001' attr1 = 'NEX' )
            act = l_ref_exception->if_t100_message~t100key ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.