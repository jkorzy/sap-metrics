*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 22.09.2024 at 18:10:01
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZJKT_METRIC_CUS.................................*
DATA:  BEGIN OF STATUS_ZJKT_METRIC_CUS               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZJKT_METRIC_CUS               .
CONTROLS: TCTRL_ZJKT_METRIC_CUS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZJKT_METRIC_CUS               .
TABLES: ZJKT_METRIC_CUS                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .