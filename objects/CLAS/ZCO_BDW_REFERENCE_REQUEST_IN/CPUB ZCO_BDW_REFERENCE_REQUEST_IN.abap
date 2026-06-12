class ZCO_BDW_REFERENCE_REQUEST_IN definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods BDW_REFERENCE_REQUEST_IN
    importing
      !INPUT type ZBDW_REFERENCE_REQUEST
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to IF_PROXY_DESTINATION optional
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    preferred parameter LOGICAL_PORT_NAME
    raising
      CX_AI_SYSTEM_FAULT .