  METHOD convert_values.
    DATA l_tab_lines TYPE TABLE OF string.
    LOOP AT i_metric_values ASSIGNING FIELD-SYMBOL(<l_metric_value>).
      IF <l_metric_value>-labels IS NOT INITIAL.
        DATA(l_line) = REDUCE string(
            INIT l_str = |{ i_metric_name }\{| l_separator = ''
            FOR label IN <l_metric_value>-labels
            NEXT l_str = |{ l_str }{ l_separator }{ label-name }="{ label-value }"| l_separator =', '
         ) && |\} { <l_metric_value>-value }|.
      ELSE.
        l_line = |{ i_metric_name } { <l_metric_value>-value }|.
      ENDIF.
      APPEND l_line TO l_tab_lines.
    ENDLOOP.

    CONCATENATE LINES OF  l_tab_lines INTO r_values_string SEPARATED BY cl_abap_char_utilities=>newline.

  ENDMETHOD.