INTERFACE zetr_if_exp_validation
  PUBLIC .


  METHODS: check_validation_properties IMPORTING is_data  TYPE zetr_ddl_i_exp_head
                                       EXPORTING messages TYPE zetr_tt_messages .

  INTERFACES if_badi_interface .
ENDINTERFACE.