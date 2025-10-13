CLASS zjkt_cl_icap_request DEFINITION
  ABSTRACT
  PUBLIC
  CREATE PROTECTED.

  PUBLIC SECTION.

    TYPES: tt_request TYPE STANDARD TABLE OF xstring WITH DEFAULT KEY.

    CONSTANTS co_eol TYPE xstring VALUE `0D0A`.
    CONSTANTS co_eof TYPE xstring VALUE `300D0A0D0A`.
    CONSTANTS co_icap_method_respmod TYPE char7 VALUE 'RESPMOD'.

    CLASS-METHODS create_for_file
      IMPORTING
        i_method          TYPE char7
        i_server_url      TYPE string
        i_server_port     TYPE numc5
        i_service         TYPE string
        i_content_base64  TYPE string OPTIONAL
        i_content_bin     TYPE xstring OPTIONAL
        i_file_name       TYPE string OPTIONAL
      RETURNING
        VALUE(r_instance) TYPE REF TO zjkt_cl_icap_request
      RAISING
        zjkt_cx_icap_exception.
    METHODS get_request
      RETURNING
        VALUE(r_request) TYPE tt_request.
