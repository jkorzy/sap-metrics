  PROTECTED SECTION.
    DATA: m_tab_request TYPE tt_request.
    DATA: m_method          TYPE char7.
    DATA: m_server_host      TYPE string.
    DATA: m_server_port     TYPE numc5.
    DATA: m_service         TYPE string.
    DATA: m_server_url      TYPE string.

    METHODS constructor
      IMPORTING
        i_method      TYPE char7
        i_server_host TYPE string
        i_server_port TYPE numc5
        i_service     TYPE string.

    METHODS create_request ABSTRACT
      IMPORTING
        i_content   TYPE xstring OPTIONAL
        i_file_name TYPE string OPTIONAL.

    METHODS build_file_body
      IMPORTING
        i_content TYPE xstring.

