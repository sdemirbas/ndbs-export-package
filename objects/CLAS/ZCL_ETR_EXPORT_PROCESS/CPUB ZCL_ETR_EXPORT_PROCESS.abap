CLASS zcl_etr_export_process DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS: create_filen_orders IMPORTING iv_document_no TYPE zetr_e_filen
                                                 iv_vbeln       TYPE zetr_e_vbeln
                                                 it_vbeln       TYPE zetr_tt_billing_document,

      create_reference_document IMPORTING it_reference_document TYPE zbd_reference_document_tab
                                          iv_filen              TYPE zetr_e_filen
                                EXPORTING et_reference_document TYPE zbd_reference_document_tab
                                          et_messaging          TYPE tdt_bd_sls_message
                                RAISING   cx_soap_destination_error
                                          cx_ai_system_fault.

    INTERFACES if_oo_adt_classrun.
