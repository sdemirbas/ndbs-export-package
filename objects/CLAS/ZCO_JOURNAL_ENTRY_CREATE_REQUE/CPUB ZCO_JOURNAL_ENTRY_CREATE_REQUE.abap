class ZCO_JOURNAL_ENTRY_CREATE_REQUE definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to IF_PROXY_DESTINATION optional
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    preferred parameter LOGICAL_PORT_NAME
    raising
      CX_AI_SYSTEM_FAULT .
  methods JOURNAL_ENTRY_CREATE_REQUEST_C
    importing
      !INPUT type ZJOURNAL_ENTRY_BULK_CREATE_REQ
    exporting
      !OUTPUT type ZJOURNAL_ENTRY_BULK_CREATE_CON
    raising
      CX_AI_SYSTEM_FAULT .