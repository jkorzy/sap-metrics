  METHOD zjkt_if_dao_metric_cus~find_active_metrics.
    SELECT * FROM
        zjkt_metric_cus
        INTO TABLE @r_tab_metrics_cus
        WHERE active = 'X'.
  ENDMETHOD.