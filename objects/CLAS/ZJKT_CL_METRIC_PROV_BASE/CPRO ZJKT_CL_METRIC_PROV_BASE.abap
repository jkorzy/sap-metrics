  PROTECTED SECTION.
    DATA: m_str_metric_cus TYPE zjkt_metric_cus.
    methods:
      constructor
        IMPORTING
          i_metric TYPE zjkt_metric
        RAISING
          zjkt_cx_metrics_exception.