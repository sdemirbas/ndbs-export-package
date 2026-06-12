CLASS lhc_zetr_ddl_c_exp_invoice DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_c_exp_invoice RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zetr_ddl_c_exp_invoice RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zetr_ddl_c_exp_invoice.
    METHODS added FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_c_exp_invoice~added RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_c_exp_invoice IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD added.
    READ ENTITIES OF zetr_ddl_c_exp_invoice
       IN LOCAL MODE ENTITY zetr_ddl_c_exp_invoice
     ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(invoices).

    TYPES: BEGIN OF tys_invoices,
             billingdocument TYPE i_billingdocument-billingdocument,
           END OF tys_invoices.
    DATA: lt_invoices TYPE STANDARD TABLE OF tys_invoices,
          ls_invoice  TYPE tys_invoices.

    DATA(lt_split)    = VALUE string_table( ).
    DATA(invoice_key) = VALUE #( keys[ 1 ] OPTIONAL ).
    DATA lv_export_no TYPE zetr_e_filen.


*    " --- Hesaplamalar
    DATA(lv_weight_unit) = VALUE string( ).
    DATA(lv_volume_unit) = VALUE string( ).
    DATA(lv_gross_total) = VALUE brgew_15( ).
    DATA(lv_net_total)   = VALUE ntgew_15( ).
    DATA(lv_vol_total)   = VALUE volum_15( ).

    IF invoice_key-%param IS NOT INITIAL.
      DATA(lv_invoice_keys) = invoice_key-%param-content.
      lv_export_no = CONV zetr_e_filen( invoice_key-%param-document  ).

      SPLIT lv_invoice_keys AT ';' INTO TABLE lt_split.

      LOOP AT lt_split INTO DATA(lv_value).
        ls_invoice-billingdocument = |{ lv_value ALPHA = IN }| .
        APPEND ls_invoice TO lt_invoices.
      ENDLOOP.


      SELECT billingdocument,
             customerpaymentterms,
             incotermsclassification,
             incotermstransferlocation,
             transactioncurrency
        FROM i_billingdocument
     FOR ALL ENTRIES IN @lt_invoices
       WHERE billingdocument = @lt_invoices-billingdocument
        INTO TABLE @DATA(lt_billingdocument).

      " Item seviyesinde ağırlık ve hacim bilgilerini oku
      SELECT billingdocument,
             billingdocumentitem,
             itemgrossweight,
             itemnetweight,
             itemweightunit,
             itemvolume,
             itemvolumeunit,
             salesdocument
        FROM i_billingdocumentitem
         FOR ALL ENTRIES IN @lt_invoices
       WHERE billingdocument = @lt_invoices-billingdocument
        INTO TABLE @DATA(lt_billingdocumentitem).


      IF lt_billingdocumentitem IS NOT INITIAL.
        SELECT salesdocument, referencesddocument, shippingtype
          FROM i_salesdocument
       FOR ALL ENTRIES IN @lt_billingdocumentitem
         WHERE salesdocument = @lt_billingdocumentitem-salesdocument
          INTO TABLE @DATA(lt_salesdocument).

        SELECT partnerbasic~customer
          FROM i_billingdocitempartnerbasic AS partnerbasic
        FOR ALL ENTRIES IN @lt_billingdocumentitem
          WHERE billingdocument     = @lt_billingdocumentitem-billingdocument
            AND billingdocumentitem = @lt_billingdocumentitem-billingdocumentitem
            AND partnerfunction     = 'WE'
           INTO TABLE @DATA(lt_billingdocumentpartner).


        IF lt_billingdocumentpartner IS NOT INITIAL.
          SELECT customer, country
            FROM i_customer
         FOR ALL ENTRIES IN @lt_billingdocumentpartner
           WHERE customer  = @lt_billingdocumentpartner-customer
            INTO TABLE @DATA(lt_customer_country).
        ENDIF.



      ENDIF.

    ELSE.
      APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                          number   = '000'
                                          severity = if_abap_behv_message=>severity-error
                                          v1       = 'Lütfen belge numarası giriniz.' ) ) TO reported-zetr_ddl_c_exp_invoice.
      RETURN.
    ENDIF.

    zcl_etr_export_process=>create_filen_orders( iv_document_no = invoice_key-%param-document
                                                 iv_vbeln       = ''
                                                 it_vbeln       = lt_invoices ).

    LOOP AT lt_invoices ASSIGNING FIELD-SYMBOL(<fs_invoices>).
      APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                          number   = '000'
                                          severity = if_abap_behv_message=>severity-success
                                          v1       = |{ <fs_invoices>-billingdocument } eklenmiştir.| )
                      %key = invoice_key-%param-document ) TO reported-zetr_ddl_c_exp_invoice.

      APPEND VALUE #( %tky = invoice_key-%param-document ) TO result.
    ENDLOOP.




    LOOP AT lt_billingdocumentitem ASSIGNING FIELD-SYMBOL(<ls_item>).
      IF lv_weight_unit IS INITIAL.
        lv_weight_unit = <ls_item>-itemweightunit.
      ENDIF.

      IF <ls_item>-itemweightunit = lv_weight_unit.
        lv_gross_total = lv_gross_total + <ls_item>-itemgrossweight.
        lv_net_total   = lv_net_total   + <ls_item>-itemnetweight.
      ELSE.
        CLEAR: lv_gross_total, lv_net_total.
        lv_weight_unit = ''.
      ENDIF.

      " Volume Unit kontrolü
      IF lv_volume_unit IS INITIAL.
        lv_volume_unit = <ls_item>-itemvolumeunit.
      ENDIF.

      IF <ls_item>-itemvolumeunit = lv_volume_unit.
        lv_vol_total = lv_vol_total + <ls_item>-itemvolume.
      ELSE.
        CLEAR lv_vol_total.
        lv_volume_unit = ''.
      ENDIF.
    ENDLOOP.

    IF lv_weight_unit IS INITIAL.
      APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                          number   = '002'
                                          severity = if_abap_behv_message=>severity-warning
                                          v1       = 'Ağırlık birimleri farklı olduğu için toplam yapılamadı.' ) ) TO reported-zetr_ddl_c_exp_invoice.
    ENDIF.

    IF lv_volume_unit IS INITIAL.
      APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                          number   = '003'
                                          severity = if_abap_behv_message=>severity-warning
                                          v1       = 'Hacim birimleri farklı olduğu için toplam yapılamadı.' ) ) TO reported-zetr_ddl_c_exp_invoice.
    ENDIF.

    IF lt_salesdocument[] IS NOT INITIAL.
      READ TABLE lt_salesdocument INTO DATA(ls_sales) INDEX 1.
    ENDIF.

    " BillingDocument verileri
    IF lt_billingdocument[] IS NOT INITIAL.
      READ TABLE lt_billingdocument INTO DATA(ls_bill) INDEX 1.

      SELECT SINGLE FROM zetr_ddl_i_export_invh AS ExportInvoice
       INNER JOIN   I_BillingDocumentItem  AS BillingDocumentItem ON BillingDocumentItem~BillingDocument = ExportInvoice~BillingDocument
       INNER JOIN   I_SalesDocumentItem    AS SalesDocumentItem   ON SalesDocumentItem~SalesDocument = BillingDocumentItem~SalesDocument
       INNER JOIN   I_SalesDocument        AS SalesDocument       ON SalesDocument~SalesDocument = SalesDocumentItem~SalesDocument
       INNER JOIN   I_BusinessUserBasic    AS UserBasic           ON UserBasic~UserID = SalesDocument~CreatedByUser
       FIELDS
         UserBasic~PersonFullName
       WHERE ExportInvoice~billingdocument EQ @ls_bill-billingdocument
       INTO @DATA(lv_person).


      SELECT SINGLE invoiceid
      FROM zetr_ddl_i_outgoing_invoices
      WHERE ( Response = 'X' OR Response = '0' OR Response = '2' )
      AND ( StatusCode IS NOT INITIAL OR StatusCode NE '2' )
      AND  documentnumber EQ @ls_bill-billingdocument
      INTO @DATA(lv_invoiceid).

    ENDIF.

    IF lt_customer_country IS NOT INITIAL.
      READ TABLE lt_customer_country INTO DATA(ls_customer_country) INDEX 1.
    ENDIF.

    IF sy-subrc = 0.

      UPDATE zetr_t_r101
         SET pymty       = @ls_bill-customerpaymentterms,
             inc01       = @ls_bill-incotermsclassification,
             inc02       = @ls_bill-incotermstransferlocation,
             trnty       = @ls_sales-shippingtype,
             desco       = @ls_customer_country-country,
             brgew       = @lv_gross_total,
             brgew_gewei = @lv_weight_unit,
             ntgew       = @lv_net_total,
             ntgew_gewei = @lv_weight_unit,
             volum       = @lv_vol_total,
             gewei       = @lv_volume_unit,
             bfrrp       = @lv_person,
             extfn       = @lv_invoiceid
       WHERE filen       = @lv_export_no.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zetr_ddl_c_exp_invoice DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zetr_ddl_c_exp_invoice IMPLEMENTATION.

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