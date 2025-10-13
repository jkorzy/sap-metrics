private section.

  data M_REF_HANDLER type ref to ZJKT_CL_ICAP_APC_HANDLER .
  data M_SERVER_HOST type STRING .
  data M_SERVER_PORT type NUMC5 .
  data M_SERVICE type STRING .
  data M_REF_APC_CLIENT type ref to IF_APC_WSP_CLIENT .

  methods SEND_MESSAGE
    importing
      !I_MESSAGE type XSTRING
    raising
      CX_APC_ERROR .