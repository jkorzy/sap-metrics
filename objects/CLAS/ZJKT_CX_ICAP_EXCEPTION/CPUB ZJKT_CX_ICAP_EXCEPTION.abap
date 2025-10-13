CLASS zjkt_cx_icap_exception DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF  not_icap_response,
        msgid TYPE symsgid VALUE 'ZJKT_ICAP',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF not_icap_response .

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .