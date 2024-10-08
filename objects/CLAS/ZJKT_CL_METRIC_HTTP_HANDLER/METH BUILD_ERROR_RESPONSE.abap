  METHOD build_error_response.

    DATA(l_status) = COND i( WHEN i_status IS INITIAL THEN 500 ELSE i_status ).
    DATA(l_reason) = COND string(
        WHEN i_message IS NOT INITIAL THEN i_message
        WHEN i_ref_exception IS BOUND THEN i_ref_exception->get_text( )
        WHEN l_status EQ 500 THEN 'Internal Server error'
    ).

    i_ref_server->response->set_status( code = l_status reason = l_reason ).


  ENDMETHOD.