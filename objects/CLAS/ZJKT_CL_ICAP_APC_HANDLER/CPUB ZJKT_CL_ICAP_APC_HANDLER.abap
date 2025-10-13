CLASS zjkt_cl_icap_apc_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    data m_ref_icap_response type ref to zjkt_cl_icap_response.
    INTERFACES if_apc_wsp_event_handler_base .
    INTERFACES if_apc_wsp_event_handler .