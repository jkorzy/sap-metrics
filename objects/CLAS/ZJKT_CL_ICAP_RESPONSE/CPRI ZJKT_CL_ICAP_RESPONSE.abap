  PRIVATE SECTION.

    DATA m_icap_header TYPE ts_icap_header.
    DATA m_http_header TYPE ts_http_header.


    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter i_icap_response | <p class="shorttext synchronized" lang="en"></p>
    "! @raising zjkt_cx_icap_exception | <p class="shorttext synchronized" lang="en"></p>
    METHODS read_icap_header
      IMPORTING
        i_icap_response TYPE xstring
      RAISING
        zjkt_cx_icap_exception.
