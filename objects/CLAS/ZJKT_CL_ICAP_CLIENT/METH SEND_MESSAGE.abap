  METHOD send_message.

    FINAL(message_manager) = CAST if_apc_wsp_message_manager(
            m_ref_apc_client->get_message_manager( ) ).
    FINAL(message) = CAST if_apc_wsp_message( message_manager->create_message( ) ).

    message->set_binary( i_message ).
    message_manager->send( message ).
  ENDMETHOD.