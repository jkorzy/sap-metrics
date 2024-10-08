**********************************************************************
* Test double zjkt_metric_provider
**********************************************************************
CLASS ltd_metric_provider DEFINITION FOR TESTING
    INHERITING FROM zjkt_cl_metric_prov_base
    CREATE PUBLIC.
  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        i_metric TYPE zjkt_metric
      raising
        zjkt_cx_metrics_exception.

    METHODS zjkt_if_metric_provider~get_metric_values REDEFINITION.

  PRIVATE SECTION.
    DATA: m_metric TYPE string.

ENDCLASS.

CLASS ltd_metric_provider IMPLEMENTATION.
  METHOD constructor.
    super->constructor( i_metric ).
    m_metric = i_metric.
  ENDMETHOD.



  METHOD zjkt_if_metric_provider~get_metric_values.
    CASE m_metric.
      WHEN  'M1'.
        r_tab_metric_values = VALUE #(
            ( labels = VALUE #( ( name = 'label1' value = 'test11' ) ( name = 'label2' value = 'test12' ) ) value = '1.744' )
            ( labels = VALUE #( ( name = 'label1' value = 'test21' ) ( name = 'label2' value = 'test22' ) ) value = '5.744' )
         ).
      WHEN 'M2'.
        r_tab_metric_values = VALUE #( ( value = '9.737' ) ).
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

**********************************************************************
* Test Double Provider Class Factory
**********************************************************************

CLASS ltd_provider_factory DEFINITION FOR TESTING
   INHERITING FROM zjkt_cl_metric_prov_factory
   CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS get_instance REDEFINITION.

ENDCLASS.


CLASS ltd_provider_factory IMPLEMENTATION.

  METHOD get_instance.
    r_ref_instance = NEW ltd_metric_provider( i_metric ).
  ENDMETHOD.

ENDCLASS.


**********************************************************************
* Test Double Metric Customizing DAO
**********************************************************************

CLASS ltd_dao_metric_cus DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES zjkt_if_dao_metric_cus PARTIALLY IMPLEMENTED.
    METHODS constructor.
  PRIVATE SECTION.
    DATA m_tab_cust TYPE zjkt_if_dao_metric_cus=>tt_metrics_cus.
ENDCLASS.

CLASS ltd_dao_metric_cus IMPLEMENTATION.

  METHOD constructor.
    m_tab_cust =  VALUE #(
        (
            metric = 'M1'
            active = abap_true
            description = 'Metric 1 Unit Test'
            met_type = zjkt_if_dao_metric_cus=>con_metric_type_counter
            name = 'test_metric_1'
            prov_type = zjkt_if_dao_metric_cus=>con_met_provider_class
            prov_name = 'TEST1'
        )
        (
            metric = 'M2'
            active = abap_true
            description = 'Metric 2 Unit Test'
            met_type = zjkt_if_dao_metric_cus=>con_metric_type_gauge
            name = 'test_metric_2'
            prov_type = zjkt_if_dao_metric_cus=>con_met_provider_class
            prov_name = 'TEST2'
        )
     ).
  ENDMETHOD.

  METHOD zjkt_if_dao_metric_cus~find_active_metrics.
    r_tab_metrics_cus = m_tab_cust.
  ENDMETHOD.

  METHOD zjkt_if_dao_metric_cus~read.
    TRY.
        r_str_metric = m_tab_cust[ metric = i_metric ].
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zjkt_cx_metrics_exception.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.


**********************************************************************
* Test Class
**********************************************************************

CLASS ltcl_unit DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      setup,
      get_metrics FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_unit IMPLEMENTATION.

  METHOD setup.
    zjkt_cl_daof_metric_cus=>s_create( )->set_instance( NEW ltd_dao_metric_cus( ) ).
    zjkt_cl_metric_prov_factory=>s_create( NEW ltd_provider_factory( ) ).
  ENDMETHOD.

  METHOD get_metrics.

    DATA(l_ref_cut) = NEW zjkt_cl_metrics( ).

    DATA(l_metrics) = l_ref_cut->zjkt_if_metrics~get_metrics( ).



    data(l_exp_metrics) = VALUE zjkt_if_metrics=>tt_metrics(
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



    "Check that number of metrics is as expected
    cl_abap_unit_assert=>assert_equals( msg = 'Number of metrics' exp = lines( l_exp_metrics ) act = lines( l_metrics ) ).

    "Check content of metrics
    DATA l_metric_string TYPE string.

    LOOP AT l_metrics ASSIGNING FIELD-SYMBOL(<l_wrk_metric>).

      cl_abap_unit_assert=>assert_table_contains(
        EXPORTING
          line             = <l_wrk_metric>
          table            = l_exp_metrics
      ).
    ENDLOOP.






  ENDMETHOD.


ENDCLASS.