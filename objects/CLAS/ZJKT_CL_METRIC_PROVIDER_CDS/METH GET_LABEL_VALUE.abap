  METHOD get_label_value.

    ASSIGN COMPONENT i_label_name OF STRUCTURE i_record TO FIELD-SYMBOL(<l_value>).

    r_label_value = <l_value>.

  ENDMETHOD.