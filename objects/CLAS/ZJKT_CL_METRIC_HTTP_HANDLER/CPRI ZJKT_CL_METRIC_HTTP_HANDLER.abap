  PRIVATE SECTION.
    "! <p class="shorttext synchronized" lang="en">Build metric response</p>
    "! Method converts internal representation of the metrics into string
    "! @parameter i_ref_server | <p class="shorttext synchronized" lang="en">Reference to IF_HTTP_SERVER</p>
    "! @parameter i_tab_metrics | <p class="shorttext synchronized" lang="en">Internal representation of the metrics</p>
    METHODS build_response
      IMPORTING
        i_ref_server  TYPE REF TO if_http_server
        i_tab_metrics TYPE zjkt_if_metrics=>tt_metrics.

    "! <p class="shorttext synchronized" lang="en">Build error response</p>
    "! Method builds an error response:
    "! <ul>
    "! <li>HTTP Response Status Code: Status provided by parameter I_STATUS or 500 if not provided</li>
    "! <li>Reason: Message provided in parameter I_MESSAGE or Text of the exception provided in I_REF_EXCEPTION.
    "! if none of both parameters is provided then 'Internal Server Error' </li>
    "! </ul>
    "!
    "! @parameter i_ref_server | <p class="shorttext synchronized" lang="en">Reference to IF_HTTP_SERVER</p>
    "! @parameter i_status | <p class="shorttext synchronized" lang="en">HTTP Response Status Code</p>
    "! @parameter i_ref_exception | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter i_message | <p class="shorttext synchronized" lang="en"></p>
    METHODS build_error_response
      IMPORTING
        i_ref_server    TYPE REF TO if_http_server
        i_status        TYPE i DEFAULT 500
        i_ref_exception TYPE REF TO cx_root OPTIONAL
        i_message       TYPE string OPTIONAL.



    "! <p class="shorttext synchronized" lang="en">Convert metric values to string</p>
    "! Method converts metric values into output string
    "! @parameter i_metric_name | <p class="shorttext synchronized" lang="en">External metric name</p>
    "! @parameter i_metric_values | <p class="shorttext synchronized" lang="en">Internal representation of metric values</p>
    "! @parameter r_values_string | <p class="shorttext synchronized" lang="en">Result string</p>
    METHODS convert_values
      IMPORTING
        i_metric_name          TYPE zjkt_met_name
        i_metric_values        TYPE zjkt_if_metrics=>tt_values
      RETURNING
        VALUE(r_values_string) TYPE string.


