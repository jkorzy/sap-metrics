INTERFACE zjkt_if_metric_provider
  PUBLIC .


  METHODS:

    "! <p class="shorttext synchronized" lang="en">Metric name</p>
    "! Method returns name of the metric as it will be shown in metrics output
    "! @parameter r_name | <p class="shorttext synchronized" lang="en"></p>
    get_metric_name
      RETURNING
        VALUE(r_name) TYPE zjkt_met_name,

    "! <p class="shorttext synchronized" lang="en">Metric description</p>
    "! Returns metric description which will showed after #HELP token
    "! @parameter r_help | <p class="shorttext synchronized" lang="en"></p>
    get_metric_decription
      RETURNING
        VALUE(r_help) TYPE string,

    "! <p class="shorttext synchronized" lang="en">Metric Type</p>
    "! Returns metric type
    "! @parameter r_metric_type | <p class="shorttext synchronized" lang="en"></p>
    get_metric_type
      RETURNING
        VALUE(r_metric_type) TYPE zjkt_met_type,

    "! <p class="shorttext synchronized" lang="en">Metric Values</p>
    "! Returns metric values for all combinations of labels
    "! @parameter r_tab_metric_values | <p class="shorttext synchronized" lang="en"></p>
    get_metric_values
      RETURNING
        VALUE(r_tab_metric_values) TYPE zjkt_if_metrics=>tt_values.



ENDINTERFACE.