"! <p class="shorttext synchronized" lang="en">DAO: Metrics Customizing</p>
INTERFACE zjkt_if_dao_metric_cus
  PUBLIC .
  TYPES: tt_metrics_cus TYPE SORTED TABLE OF zjkt_metric_cus WITH UNIQUE KEY primary_key COMPONENTS client metric.
  CONSTANTS:
    con_metric_type_counter TYPE zjkt_met_type VALUE 'CNT',
    con_metric_type_gauge   TYPE zjkt_met_type VALUE 'GAU',
    con_met_provider_cds    TYPE zjkt_met_prov_type VALUE 'V',
    con_met_provider_class  TYPE zjkt_met_prov_type VALUE 'C'.

  "! <p class="shorttext synchronized" lang="en">Read metric by key</p>
  "! Method reads customizing of the single metric selected by metric key
  "! @parameter i_metric | <p class="shorttext synchronized" lang="en">Metric key</p>
  "! @parameter r_str_metric | <p class="shorttext synchronized" lang="en">Settings of the metric</p>
  "! @raising zjkt_cx_metrics_exception | <p class="shorttext synchronized" lang="en">Error occurred when reading customizing of the metric</p>
  METHODS read
    IMPORTING
      i_metric            TYPE zjkt_metric
    RETURNING
      VALUE(r_str_metric) TYPE zjkt_metric_cus
    raising
      zjkt_cx_metrics_exception.

  "! <p class="shorttext synchronized" lang="en">Read active metrics</p>
  "! Method reads customizing of all active metrics.
  "! @parameter r_tab_metrics_cus | <p class="shorttext synchronized" lang="en">Settings of active metrics</p>
  METHODS find_active_metrics
    RETURNING
      VALUE(r_tab_metrics_cus) TYPE tt_metrics_cus.
ENDINTERFACE.