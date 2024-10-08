  METHOD zjkt_if_dao_metric_cus~read.

    SELECT SINGLE * FROM
      zjkt_metric_cus
      INTO @r_str_metric
      WHERE metric = @i_metric.

    IF sy-subrc NE 0.
      MESSAGE e001(zjkt_metrics_dal) WITH i_metric INTO DATA(l_dummy).
      zjkt_cx_metrics_exception=>raise( ).
    ENDIF.

  ENDMETHOD.