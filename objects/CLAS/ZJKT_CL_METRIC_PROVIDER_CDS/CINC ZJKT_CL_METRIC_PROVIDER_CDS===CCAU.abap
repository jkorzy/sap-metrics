**********************************************************************
*Test Double for ZJKT_IF_DAO_METRIC_CUST
**********************************************************************

CLASS ltd_dao_metric_cust DEFINITION FOR TESTING.

  PUBLIC SECTION.
    INTERFACES zjkt_if_dao_metric_cus PARTIALLY IMPLEMENTED.

ENDCLASS.

CLASS ltd_dao_metric_cust IMPLEMENTATION.

  METHOD zjkt_if_dao_metric_cus~read.
    IF i_metric = '01'.
      r_str_metric = VALUE #(
          client = sy-mandt
          metric = '01'
          met_type = zjkt_if_dao_metric_cus=>con_metric_type_counter
          description = 'Test Metric'
          name = 'test.metric'
          prov_name = 'ZJKT_METR_BOOK_CNT'
          prov_type = zjkt_if_dao_metric_cus=>con_met_provider_cds
      ).
    ELSEIF i_metric = '02'.
      r_str_metric = VALUE #(
          client = sy-mandt
          metric = '01'
          met_type = zjkt_if_dao_metric_cus=>con_metric_type_counter
          description = 'Wrong CDS'
          name = 'test.metric.wrong'
          prov_name = 'ZJKT_NOT_EXISTING'
          prov_type = zjkt_if_dao_metric_cus=>con_met_provider_cds
      ).
    ELSE.
      MESSAGE e001(zjkt_metrics_dal) WITH i_metric INTO DATA(l_dummy).
      zjkt_cx_metrics_exception=>raise( ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.

**********************************************************************

CLASS ltcl_unit DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA: s_ref_environment TYPE REF TO if_osql_test_environment .
    class-methods:
        class_setup.
    METHODS:
      setup,
      teardown,
      create_for_wrong_metric FOR TESTING RAISING cx_static_check,
      create_for_wrong_cds FOR TESTING RAISING cx_static_check,
      get_metric_values FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_unit IMPLEMENTATION.

  METHOD class_setup.
    s_ref_environment = cl_osql_test_environment=>create( VALUE #( ( 'ZJKT_METR_BOOK_CNT' ) ) ).
  ENDMETHOD.

  METHOD setup.
    zjkt_cl_daof_metric_cus=>s_create( )->set_instance( NEW ltd_dao_metric_cust(  ) ).
    DATA l_tab_data TYPE TABLE OF ZJKT_METR_BOOK_CNT.
    l_tab_data = VALUE #(
                          ( carrier = 'AA' value = '1222' )
                          ( carrier = 'LH' value = '555' )
                        ).
    s_ref_environment->insert_test_data( l_tab_data ).
  ENDMETHOD.

  METHOD teardown.
    s_ref_environment->clear_doubles( ).
  ENDMETHOD.

  METHOD create_for_wrong_metric.
    TRY.
        DATA(l_ref_cut) = NEW zjkt_cl_metric_provider_cds( 'NEX' ).
        cl_abap_unit_assert=>fail( msg = 'Expected exception not raised.' ).
      CATCH zjkt_cx_metrics_exception INTO DATA(l_ref_exception).
        cl_abap_unit_assert=>assert_equals(
            msg = 'Wrong message raised'
            exp = VALUE scx_t100key( msgid = 'ZJKT_METRICS_DAL' msgno = '001' attr1 = 'NEX' )
            act = l_ref_exception->if_t100_message~t100key ).
    ENDTRY.
  ENDMETHOD.



  METHOD create_for_wrong_cds.
    TRY.
        DATA(l_ref_cut) = NEW zjkt_cl_metric_provider_cds( '02' ).
        cl_abap_unit_assert=>fail( msg = 'Expected exception not raised.' ).
      CATCH zjkt_cx_metrics_exception INTO DATA(l_ref_exception).
        cl_abap_unit_assert=>assert_equals(
            msg = 'Wrong message raised'
            exp = VALUE scx_t100key( msgid = 'ZJKT_METRICS_PROV' msgno = '001' attr1 = 'ZJKT_NOT_EXISTING' )
            act = l_ref_exception->if_t100_message~t100key ).
    ENDTRY.
  ENDMETHOD.

  METHOD get_metric_values.
    DATA(l_ref_cut) = NEW zjkt_cl_metric_provider_cds( '01' ).
    data(l_result) = l_ref_cut->zjkt_if_metric_provider~get_metric_values( ).

    data(l_expected) = value zjkt_if_metrics=>tt_values(
        ( labels = value #( ( name = 'CARRIER' value = 'AA' ) ) value = '1222' )
        ( labels = value #( ( name = 'CARRIER' value = 'LH' ) ) value = '555' )
    ).

    cl_abap_unit_assert=>assert_equals( msg = 'Metric values not correct' exp = l_expected act = l_result ).

  ENDMETHOD.



ENDCLASS.