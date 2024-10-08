  METHOD zjkt_if_metric_provider~get_metric_values.

    DATA l_ref_values TYPE REF TO data.

    CREATE DATA l_ref_values TYPE TABLE OF (m_cds_name).

    SELECT * FROM (m_cds_name)
      INTO TABLE @l_Ref_values->*.


    LOOP AT l_ref_values->* ASSIGNING FIELD-SYMBOL(<l_str_value>).

      "Add new line to result table
      APPEND INITIAL LINE TO r_tab_metric_values ASSIGNING FIELD-SYMBOL(<l_wrk_result>).

      "Get the 'VALUE' field from CDS-View
      ASSIGN COMPONENT 'VALUE' OF STRUCTURE <l_str_value> TO FIELD-SYMBOL(<l_metric_value>).
      <l_wrk_result>-value = <l_metric_value>.
      CONDENSE <l_wrk_result>-value NO-GAPS.


      "Rest of CS-View fields are labels. We get the name of each field and its value and put in labels table
      DATA(l_ref_type) = CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_data( <l_str_value> ) ).

      <l_wrk_result>-labels = VALUE #( FOR label IN l_ref_type->components WHERE ( name NE 'VALUE' ) (
        name = label-name
        value = get_label_value( i_record = <l_str_value> i_label_name = CONV #( label-name ) ) ) ).
    ENDLOOP.

  ENDMETHOD.