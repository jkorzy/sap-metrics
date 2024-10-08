INTERFACE zjkt_if_metrics
  PUBLIC .

  TYPES: BEGIN OF ts_labels,
           name  TYPE string,
           value TYPE string,
         END OF ts_labels.

  TYPES tt_labels TYPE STANDARD TABLE OF ts_labels WITH KEY primary_key COMPONENTS name.

  TYPES: BEGIN OF ts_values,
           labels TYPE tt_labels,
           value  TYPE string,
         END OF ts_values.

  TYPES: tt_values TYPE STANDARD TABLE OF ts_values WITH DEFAULT KEY.

  TYPES: BEGIN OF ts_metric,
           name        TYPE zjkt_met_name,
           description TYPE string,
           met_type    TYPE zjkt_met_type,
           values      TYPE tt_values,
         END OF ts_metric.

  TYPES: tt_metrics TYPE STANDARD TABLE OF ts_metric WITH KEY primary_key COMPONENTS name.

  METHODS get_metrics
    RETURNING
      VALUE(r_tab_metrics) TYPE tt_metrics
    RAISING
      zjkt_cx_metrics_exception.

ENDINTERFACE.