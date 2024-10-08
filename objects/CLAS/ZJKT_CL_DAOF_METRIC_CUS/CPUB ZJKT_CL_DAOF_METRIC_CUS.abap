CLASS zjkt_cl_daof_metric_cus DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-METHODS s_create
      IMPORTING
        i_ref_factory        TYPE REF TO zjkt_cl_daof_metric_cus OPTIONAL
      RETURNING
        VALUE(r_ref_factory) TYPE REF TO zjkt_cl_daof_metric_cus.

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    CLASS-METHODS free.


    METHODS get_instance
      RETURNING
        VALUE(r_Ref_instance) TYPE REF TO zjkt_if_dao_metric_cus.

    METHODS set_instance
      IMPORTING
        i_ref_instance TYPE REF TO zjkt_if_dao_metric_cus.
