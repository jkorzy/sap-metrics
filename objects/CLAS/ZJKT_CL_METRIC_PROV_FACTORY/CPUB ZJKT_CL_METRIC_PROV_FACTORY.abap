CLASS zjkt_cl_metric_prov_factory DEFINITION
  PUBLIC
  CREATE PROTECTED .

  PUBLIC SECTION.
    CLASS-METHODS s_create
      IMPORTING
        i_ref_factory        TYPE REF TO zjkt_cl_metric_prov_factory OPTIONAL
      RETURNING
        VALUE(r_ref_factory) TYPE REF TO zjkt_cl_metric_prov_factory.

    METHODS get_instance
      IMPORTING
        i_metric              TYPE zjkt_metric
      RETURNING
        VALUE(r_ref_instance) TYPE REF TO zjkt_if_metric_provider
      RAISING
        zjkt_cx_metrics_exception.
