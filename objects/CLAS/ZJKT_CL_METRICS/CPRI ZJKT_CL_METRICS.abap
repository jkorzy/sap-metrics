  PRIVATE SECTION.
    METHODS get_metric
      IMPORTING
        i_str_metr_cus  TYPE zjkt_metric_cus
      RETURNING
        VALUE(r_metric) TYPE zjkt_if_metrics=>ts_metric
      RAISING
        zjkt_cx_metrics_exception.