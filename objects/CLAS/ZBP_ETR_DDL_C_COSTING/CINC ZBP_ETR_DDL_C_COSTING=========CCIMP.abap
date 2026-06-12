CLASS lhc_zetr_ddl_c_costing DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_c_costing RESULT result.

    METHODS onsave FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_c_costing~onsave RESULT result.


    CONSTANTS: cv_original_refdoc_type TYPE zjournal_entry_create_request-journal_entry-original_reference_document_ty VALUE 'BKPFF',
               cv_business_trans_type  TYPE zjournal_entry_create_request-journal_entry-business_transaction_type      VALUE 'RFBU',
               cv_accounting_doc_type  TYPE zjournal_entry_create_request-journal_entry-accounting_document_type       VALUE 'KR',
               cv_currency_try         TYPE zcurrency_code     VALUE 'TRY',
               cv_debit_credit_code_s  TYPE zdebit_credit_code VALUE 'S',
               cv_debit_credit_code_h  TYPE zdebit_credit_code VALUE 'H',
               cv_created_by_user      TYPE zjournal_entry_create_request-journal_entry-created_by_user VALUE 'EXPORT_USER'.

ENDCLASS.

CLASS lhc_zetr_ddl_c_costing IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD onsave.

    DATA lt_request  TYPE TABLE OF zjournal_entry_create_request.
    DATA lt_items    TYPE zjournal_entry_create_request-journal_entry-item.
    DATA lt_creditor TYPE zjournal_entry_create_request-journal_entry-creditor_item.
    DATA lt_tax      TYPE zjournal_entry_create_req_tab2.
    DATA ls_header   TYPE zjournal_entry_create_request-journal_entry.
    DATA lt_item_tax TYPE zjournal_entry_create_request2.
    DATA lt_account_assignment TYPE zjournal_entry_create_request8.
    DATA(lv_sign)            = 1.
    DATA(lv_conv_debit_code) = VALUE zdebit_credit_code(  ).
    DATA lt_data TYPE  zjournal_entry_create_requ_tab.
    DATA(ls_key) = VALUE #( keys[ 1 ] OPTIONAL ).
    DATA(ls_headers) = ls_key-%param-_table2.
    DATA lt_log_journal_entry TYPE TABLE OF zetr_t_exp130.



    SELECT * FROM zetr_t_exp120 INTO TABLE @DATA(lt_costing_account).
    SELECT * FROM zetr_t_exp129 INTO TABLE @DATA(lt_tax_account).

    IF ls_key-%param-_table IS NOT INITIAL.

      LOOP AT ls_key-%param-_table ASSIGNING FIELD-SYMBOL(<row>).
        <row>-document_no = |{ <row>-document_no ALPHA = IN }|.
      ENDLOOP.

      SELECT *
        FROM zetr_ddl_c_exp_invi
     FOR ALL ENTRIES IN @ls_key-%param-_table
       WHERE vbeln = @ls_key-%param-_table-document_no
        INTO TABLE @DATA(lt_invoice_item).
    ENDIF.

    SELECT SINGLE *
             FROM zetr_ddl_i_vorgang
            WHERE vorgang = @ls_headers-process
             INTO @DATA(ls_vorgang).

    ls_header = VALUE #( original_reference_document_ty = cv_original_refdoc_type
                         business_transaction_type      = cv_business_trans_type
                        " accounting_document_type       = ls_vorgang-blart
                         accounting_document_type       = ls_headers-document_type
                         document_reference_id          = ls_headers-reference
                         document_header_text           = ls_headers-text
                         created_by_user                = cv_created_by_user
                         company_code                   = ls_headers-company_code
                         tax_determination_date         = ls_headers-document_date
                         document_date                  = ls_headers-document_date
                         posting_date                   = ls_headers-created_date
                         exchange_rate                  = ls_headers-exchange_rate  ).

    APPEND VALUE #( reference_document_item              = 1
                    creditor                             = ls_headers-supplier
                    amount_in_transaction_currency       = VALUE #( currency_code = ls_headers-waers
                                                                    content       =  ( ls_headers-amount + ls_headers-tax_amount ) * -1  )"
                    debit_credit_code                    = cv_debit_credit_code_h ) TO lt_creditor.

    LOOP AT ls_key-%param-_table INTO DATA(ls_data).
      DATA(lv_tabix) = sy-tabix.

      IF lt_invoice_item IS NOT INITIAL.
        DATA(ls_invoice_item) = VALUE #( lt_invoice_item[ vbeln  = ls_data-document_no  ] OPTIONAL ).
      ENDIF.

      APPEND VALUE #( reference_document_item        = lv_tabix
                      company_code                   = ls_headers-company_code
                      glaccount                      = VALUE #( content = VALUE #( lt_costing_account[ ctype = ls_data-costing_type ]-saknr OPTIONAL )  )
                      account_assignment             = VALUE #( cost_center = ls_data-cost_center )
                      debit_credit_code              = cv_debit_credit_code_s
                      amount_in_transaction_currency = VALUE #( currency_code = ls_headers-waers
                                                                content       = ls_data-cost_amount  )
*                      document_item_text             = ls_data-text
                      document_item_text             = ls_data-costing_type
                      assignment_reference           = ls_invoice_item-filen
                      tax                            = COND #( WHEN ls_data-tax_type IS NOT INITIAL
                                                               THEN VALUE #( tax_code = VALUE #( content = ls_data-tax_type ) )  ) ) TO lt_items.

*      APPEND VALUE #( reference_document_item              = lv_tabix
*                      company_code                         = ls_headers-company_code
*                      glaccount                            = VALUE #( content = VALUE #( lt_costing_account[  ctype  = ls_data-costing_type  ]-saknr OPTIONAL )  )
*                      account_assignment                   = VALUE #( cost_center = ls_data-cost_center )
*                      debit_credit_code                    = cv_debit_credit_code_s
*                      amount_in_transaction_currency       = VALUE #( currency_code = ls_headers-waers
*                                                                      content       = ls_data-cost_amount  )
*                      document_item_text                   = ls_data-text
*                      assignment_reference                 = ls_invoice_item-filen
*                      tax                                  = VALUE #( tax_code = VALUE #( content = ls_data-tax_type ) ) ) TO lt_items.


      IF ls_data-tax_type IS NOT INITIAL. "AND ls_headers-tax_amount IS NOT INITIAL.
        APPEND INITIAL LINE TO lt_tax ASSIGNING FIELD-SYMBOL(<fs_tax>).

        <fs_tax>-tax_code-content                             = ls_data-tax_type.
        <fs_tax>-tax_item_classification                      = VALUE #( lt_tax_account[ vergikodu = ls_data-tax_type  ]-kalem OPTIONAL ) .
        <fs_tax>-condition_type                               = VALUE #( lt_tax_account[ vergikodu = ls_data-tax_type  ]-kosul OPTIONAL ) .
        <fs_tax>-debit_credit_code                            = cv_debit_credit_code_s.

        <fs_tax>-tax_base_amount_in_trans_crcy-currency_code  = ls_headers-waers.
        <fs_tax>-tax_base_amount_in_trans_crcy-content        = ls_data-cost_amount.

        <fs_tax>-amount_in_transaction_currency-content       = ls_data-tax_amount .
        <fs_tax>-amount_in_transaction_currency-currency_code = ls_headers-waers.
      ENDIF.
    ENDLOOP.

    GET TIME STAMP FIELD DATA(lv_date_time).

    APPEND VALUE #( message_header = VALUE #( creation_date_time = lv_date_time )
                    journal_entry  = VALUE #( BASE ls_header
                                                   item              = lt_items
                                                   creditor_item     = lt_creditor
                                                   product_tax_item  = lt_tax ) ) TO lt_request.
    TRY.
        zetr_exp_journal_entry=>create_journal_entry( EXPORTING it_data     = lt_request
                                                      IMPORTING et_response = DATA(lt_response) ).

        LOOP AT lt_response REFERENCE INTO DATA(lr_response).
          DATA(lv_message_text) = ``.
          DATA(lv_lines) = lines( lr_response->log-item ).

          LOOP AT lr_response->log-item ASSIGNING FIELD-SYMBOL(<fs_logitem>).

            " Eğer birden fazla satır varsa ilk satırı atla
            IF lv_lines > 1 AND sy-tabix = 1.
              CONTINUE.
            ENDIF.

            DATA(lv_msg) = <fs_logitem>-note.
            DATA(lv_v1)  = lv_msg(50).
            DATA(lv_v2)  = lv_msg+50(50).
            DATA(lv_v3)  = lv_msg+100(50).
            DATA(lv_v4)  = lv_msg+150(50).

            CONDENSE: lv_v1, lv_v2, lv_v3, lv_v4.

            APPEND VALUE #(
              %msg = new_message(
                id       = 'ZETR_EXP'
                number   = '000'
                severity = if_abap_behv_message=>severity-error
                v1       = lv_v1
                v2       = lv_v2
                v3       = lv_v3
                v4       = lv_v4
              )
            ) TO reported-zetr_ddl_c_costing.

          ENDLOOP.
*          LOOP AT lr_response->log-item ASSIGNING FIELD-SYMBOL(<fs_logitem>).
*
*
*            IF sy-tabix > 1.
*
*              DATA(lv_msg) = <fs_logitem>-note.
*              DATA(lv_v1)  = lv_msg(50).
*              DATA(lv_v2)  = lv_msg+50(50).
*              DATA(lv_v3)  = lv_msg+100(50).
*              DATA(lv_v4)  = lv_msg+150(50).
*
*              CONDENSE: lv_v1, lv_v2, lv_v3, lv_v4.
*
*              APPEND VALUE #( %msg = new_message( id       = 'ZETR_EXP'
*                                                  number   = '000'
*                                                  severity = if_abap_behv_message=>severity-error
*                                                  v1       = lv_v1
*                                                  v2       = lv_v2
*                                                  v3       = lv_v3
*                                                  v4       = lv_v4 )  ) TO reported-zetr_ddl_c_costing.
*            ENDIF.
*          ENDLOOP.

          IF lr_response->journal_entry_create_confirmat-accounting_document IS INITIAL
          OR lr_response->journal_entry_create_confirmat-accounting_document = '0000000000'.

            APPEND VALUE #( %msg = new_message( id       = 'ZETR_EXP'
                                                number   = '000'
                                                v1       = lv_v1
                                                v2       = lv_v2
                                                v3       = lv_v3
                                                v4       = lv_v4
                                                severity = if_abap_behv_message=>severity-error ) ) TO reported-zetr_ddl_c_costing.

          ELSE.
            DATA(lv_accountingdoc) = lr_response->journal_entry_create_confirmat-accounting_document.
            DATA(lv_fiscalyear)    = lr_response->journal_entry_create_confirmat-fiscal_year.

            APPEND VALUE #( %msg = new_message( id       = 'ZETR_EXP'
                                                number   = '005'
                                                v1       = lv_accountingdoc
                                                severity = if_abap_behv_message=>severity-success ) ) TO reported-zetr_ddl_c_costing.
            TRY.

                APPEND VALUE zetr_t_exp130( filen         = ls_invoice_item-filen
                                            company_code  = ls_headers-company_code
                                            journal_entry = lv_accountingdoc
                                            fiscal_year   = lv_fiscalyear
                                            erdat         = cl_abap_context_info=>get_system_date( )
                                            erzet         = cl_abap_context_info=>get_system_time( )
                                            ernam         = cl_abap_context_info=>get_user_business_partner_id( ) ) TO lt_log_journal_entry.

              CATCH cx_abap_context_info_error.
            ENDTRY.
          ENDIF.
        ENDLOOP.

        IF lt_log_journal_entry[] IS NOT INITIAL.
          MODIFY zetr_t_exp130 FROM TABLE @lt_log_journal_entry.
        ENDIF.

      CATCH cx_soap_destination_error cx_ai_system_fault.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zetr_ddl_c_costing DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zetr_ddl_c_costing IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.