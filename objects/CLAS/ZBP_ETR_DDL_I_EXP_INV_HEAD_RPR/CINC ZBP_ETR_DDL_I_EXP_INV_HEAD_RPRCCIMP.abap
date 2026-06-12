CLASS lhc_zetr_ddl_i_exp_inv_head_rp DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_exp_inv_head_rpr RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zetr_ddl_i_exp_inv_head_rpr RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zetr_ddl_i_exp_inv_head_rpr.
    METHODS added FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_i_exp_inv_head_rpr~added RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_exp_inv_head_rp IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD added.
    READ ENTITIES OF zetr_ddl_i_exp_inv_head_rpr IN LOCAL MODE ENTITY zetr_ddl_i_exp_inv_head_rpr
      ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(invoices).

*    DATA(invoice_key) = VALUE #( keys[ 1 ] OPTIONAL ).
*    DATA(lv_document) = VALUE zetr_e_filen( ).
*
*    IF invoice_key-%param IS NOT INITIAL.
*      lv_document = invoice_key-%param-document.
*      zcl_etr_export_process=>create_filen_orders( iv_document_no = lv_document
*                                                   iv_vbeln       = invoice_key-billingdocument ).
*
*      APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
*                                          number   = '000'
*                                          severity = if_abap_behv_message=>severity-success
*                                          v1       = |{ invoice_key-billingdocument } numaralı belge { lv_document } numaralı ihracat dosyasına eklenmiştir.| ) ) TO reported-zetr_ddl_i_exp_inv_head_rpr.
*    ELSE.
*      APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
*                                          number   = '000'
*                                          severity = if_abap_behv_message=>severity-error
*                                          v1       = 'Lütfen belge numarası giriniz.' ) ) TO reported-zetr_ddl_i_exp_inv_head_rpr.
*
*    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zetr_ddl_i_exp_inv_head_rp DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zetr_ddl_i_exp_inv_head_rp IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.