CLASS zjkt_cl_icap_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_server_host TYPE string
        i_server_port TYPE numc5
        i_service     TYPE string
      RAISING
        zjkt_cx_icap_exception.


    METHODS scan_file
      IMPORTING
        i_file_content  TYPE xstring
        i_file_name     TYPE string
      RETURNING
        VALUE(r_result) TYPE xfeld
      RAISING
        zjkt_cx_icap_exception.
