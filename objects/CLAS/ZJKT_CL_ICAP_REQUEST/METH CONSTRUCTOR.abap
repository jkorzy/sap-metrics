  METHOD constructor.
    m_method = i_method.
    m_server_host = i_server_host.
    m_server_port = i_server_port.
    m_service = i_service.
    m_server_url = COND string(
        WHEN m_server_port IS INITIAL THEN m_server_host
        ELSE |{ m_server_host }:{ m_server_port }| ).
  ENDMETHOD.