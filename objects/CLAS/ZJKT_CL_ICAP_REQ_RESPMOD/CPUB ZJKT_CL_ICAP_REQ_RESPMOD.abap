CLASS zjkt_cl_icap_req_respmod DEFINITION
  PUBLIC
  INHERITING FROM zjkt_cl_icap_request
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_server_url  TYPE string
        i_server_port TYPE numc5
        i_service     TYPE string.