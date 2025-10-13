  METHOD if_apc_wsp_event_handler~on_error.
    WRITE: / 'Communictation error: ', i_reason.
  ENDMETHOD.