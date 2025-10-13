  METHOD if_apc_wsp_event_handler~on_message.

    try.
        m_ref_icap_response = new #( i_message->get_binary( ) ).
    catch zjkt_cx_icap_exception.
        break-point.
    catch cx_apc_error into final(r_ref_apc_error).
        BREAK-POINT.
    ENDTRY.




  ENDMETHOD.