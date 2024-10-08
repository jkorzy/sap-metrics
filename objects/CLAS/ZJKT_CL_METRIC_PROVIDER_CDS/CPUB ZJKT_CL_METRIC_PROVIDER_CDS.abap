CLASS zjkt_cl_metric_provider_cds DEFINITION
  INHERITING FROM zjkt_cl_metric_prov_base
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_metric TYPE zjkt_metric
        RAISING
          zjkt_cx_metrics_exception,
      zjkt_if_metric_provider~get_metric_values REDEFINITION.

