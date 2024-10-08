CLASS zjkt_cl_metrics_fact DEFINITION
  PUBLIC
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS s_create
      IMPORTING
        i_ref_factory        TYPE REF TO zjkt_cl_metrics_fact OPTIONAL
      RETURNING
        VALUE(r_ref_factory) TYPE REF TO zjkt_cl_metrics_fact.
    METHODS get_instance
      IMPORTING
        i_ref_instance        TYPE REF TO zjkt_if_metrics OPTIONAL
      RETURNING
        VALUE(r_ref_instance) TYPE REF TO zjkt_if_metrics.