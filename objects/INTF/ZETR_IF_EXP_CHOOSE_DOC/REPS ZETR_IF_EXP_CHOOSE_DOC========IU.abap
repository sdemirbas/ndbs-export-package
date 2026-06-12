INTERFACE zetr_if_exp_choose_doc
  PUBLIC .


  METHODS: get_choosed_document IMPORTING it_vbeln          TYPE zetr_tt_document
                                EXPORTING et_check_canceled TYPE zetr_tt_document_active.

  INTERFACES: if_badi_interface.
ENDINTERFACE.