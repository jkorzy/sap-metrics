CLASS zjkt_cl_icap_response DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ts_violation,
             file_name   TYPE string,
             threat_name TYPE string,
             resolution  TYPE char1,
           END OF ts_violation.

    TYPES: tt_violations TYPE STANDARD TABLE OF ts_violation WITH DEFAULT KEY.

    TYPES: BEGIN OF ts_infection,
             file_name      TYPE string,
             threat_name    TYPE string,
             resolution     TYPE char1,
             infection_type TYPE char1,
           END OF ts_infection.


    TYPES: BEGIN OF ts_icap_header,
             status     TYPE numc3,
             violations TYPE tt_violations,
             infection  TYPE ts_infection,
           END OF ts_icap_header.

    TYPES: BEGIN OF ts_http_header,
             status TYPE numc3,
           END OF ts_http_header.

    CONSTANTS co_block_delimiter TYPE xstring VALUE `0D0A0D0A` .

    METHODS constructor
      IMPORTING
        i_icap_response TYPE xstring
      RAISING
        zjkt_cx_icap_exception.

    METHODS get_status
      RETURNING VALUE(r_status) TYPE i.

    METHODS get_http_status
      RETURNING
        VALUE(r_http_status) TYPE numc3.
