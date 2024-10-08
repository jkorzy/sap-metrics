  METHOD raise.
    RAISE EXCEPTION TYPE zjkt_cx_metrics_exception
      EXPORTING
        textid = CORRESPONDING #( syst MAPPING attr1 = msgv1 attr2 = msgv2 attr3 = msgv3 attr4 = msgv4 ).
  ENDMETHOD.