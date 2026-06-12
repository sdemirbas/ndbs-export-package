CLASS lhc_zetr_ddl_i_exp_inv_head_rp DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_exp_inv_head_rpt RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zetr_ddl_i_exp_inv_head_rpt RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zetr_ddl_i_exp_inv_head_rpt.
    METHODS added FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_i_exp_inv_head_rpt~added RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_exp_inv_head_rp IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD added.
    READ ENTITIES OF zetr_ddl_i_exp_inv_head_rpt
IN LOCAL MODE ENTITY zetr_ddl_i_exp_inv_head_rpt
     ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(invoices).

*    DATA(invoice_key) = VALUE #( keys[ 1 ] OPTIONAL ).
*    DATA(lv_document) = VALUE zetr_e_filen( ).
*
*    IF invoice_key-%param IS NOT INITIAL.
*      lv_document = invoice_key-%param-document.
*
*      SELECT SINGLE *
*               FROM zetr_t_r101
*              WHERE filen = @lv_document
*               INTO @DATA(ls_export).
*
*      SELECT * FROM zetr_t_r102
*              WHERE filen = @lv_document
*               INTO TABLE @DATA(lt_old_document).
*
*      IF lt_old_document IS NOT INITIAL.
*
*        SELECT billingdocument, customerpaymentterms,
*               incotermsclassification,incotermstransferlocation
*          FROM i_billingdocument
*       FOR ALL ENTRIES IN @lt_old_document
*         WHERE billingdocument EQ @lt_old_document-vbeln
*          INTO TABLE @DATA(lt_old_document_detail).
*      ENDIF.
*
*
*
*      SELECT SINGLE billingdocument, transactioncurrency, customerpaymentterms,
*                      incotermsclassification,incotermstransferlocation
*                 FROM i_billingdocument
*                WHERE billingdocument EQ @invoice_key-billingdocument
*                 INTO @DATA(ls_document).
*
*
*      LOOP AT lt_old_document_detail ASSIGNING FIELD-SYMBOL(<fs_old_doc>).
*
*        IF <fs_old_doc>-customerpaymentterms        <> ls_document-customerpaymentterms
*        OR <fs_old_doc>-incotermsclassification     <> ls_document-incotermsclassification
*        OR <fs_old_doc>-incotermstransferlocation   <> ls_document-incotermstransferlocation.
*          APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
*                                              number   = '000'
*                                              severity = if_abap_behv_message=>severity-error
*                                              v1       = |Belge { ls_document-billingdocument } ile önceki belge { <fs_old_doc>-billingdocument  } arasında tutarsızlık var| ) ) TO reported-zetr_ddl_i_exp_inv_head_rpt.
*
*          EXIT.
*        ENDIF.
*      ENDLOOP.
*
*      IF reported-zetr_ddl_i_exp_inv_head_rpt IS NOT INITIAL.
*        EXIT.
*      ENDIF.
*
*      IF ls_export-iban IS NOT INITIAL.
*
*        SELECT SINGLE *
*                 FROM zetr_t_exp122
*                WHERE iban = @ls_export-iban
*                 INTO @DATA(ls_iban).
*
*
*
*        IF ls_iban-waers EQ ls_document-transactioncurrency.
*          zcl_etr_export_process=>create_filen_orders( iv_document_no = lv_document
*                                                       iv_vbeln       = invoice_key-billingdocument ).
*        ELSE.
*
*          APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
*                                              number   = '000'
*                                              severity = if_abap_behv_message=>severity-error
*                                              v1       = |{ invoice_key-billingdocument } numaralı belgenin para birimi { ls_iban-bankname } ile eşleşmemektedir.| ) ) TO reported-zetr_ddl_i_exp_inv_head_rpt.
*
*        ENDIF.
*
*      ELSE.
*
*        zcl_etr_export_process=>create_filen_orders( iv_document_no = lv_document
*                                                     iv_vbeln       = invoice_key-billingdocument ).
*
*        APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
*                                            number   = '000'
*                                            severity = if_abap_behv_message=>severity-success
*                                            v1       = |{ invoice_key-billingdocument } numaralı belge { lv_document } numaralı ihracat dosyasına eklenmiştir.| ) ) TO reported-zetr_ddl_i_exp_inv_head_rpt.
*      ENDIF.
*    ELSE.
*      APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
*                                          number   = '000'
*                                          severity = if_abap_behv_message=>severity-error
*                                          v1       = 'Lütfen belge numarası giriniz.' ) ) TO reported-zetr_ddl_i_exp_inv_head_rpt.
*
*    ENDIF.







* eski
*    DATA(invoice_key) = VALUE #( keys[ 1 ] OPTIONAL ).
*    DATA(lv_document) = VALUE zetr_e_filen( ).
*
*    IF invoice_key-%param IS NOT INITIAL.
*      lv_document = invoice_key-%param.
*      zcl_etr_export_process=>create_filen_orders( iv_document_no = lv_document
*                                                   iv_vbeln       = invoice_key-billingdocument ).
*
*      APPEND VALUE #( %msg = new_message( id       = 'ZETR_EXP'
*                                          number   = '000'
*                                          severity = if_abap_behv_message=>severity-success
*                                          v1       = |{ invoice_key-billingdocument } numaralı belge { lv_document } numaralı ihracat dosyasına eklenmiştir.| ) ) TO reported-zetr_ddl_i_exp_inv_head_rpt.
*    ELSE.
*      APPEND VALUE #( %msg = new_message( id       = 'ZETR_EXP'
*                                          number   = '000'
*                                          severity = if_abap_behv_message=>severity-error
*                                          v1       = 'Lütfen belge numarası giriniz.' ) ) TO reported-zetr_ddl_i_exp_inv_head_rpt.
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