*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZJKT_MV_METRIC_C
*   generation date: 22.09.2024 at 18:09:50
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZJKT_MV_METRIC_C   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.