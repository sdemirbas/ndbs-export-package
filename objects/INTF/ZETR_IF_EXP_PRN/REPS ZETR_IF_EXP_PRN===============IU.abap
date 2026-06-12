INTERFACE zetr_if_exp_prn
  PUBLIC .



  METHODS: get_pdf IMPORTING iv_fileexportno    TYPE zetr_e_filen
                             iv_billingdocument TYPE zetr_e_vbeln
                             iv_button          TYPE c
                             iv_dummy           TYPE string
                   EXPORTING ev_document_value  TYPE string.

  INTERFACES: if_badi_interface.

ENDINTERFACE.