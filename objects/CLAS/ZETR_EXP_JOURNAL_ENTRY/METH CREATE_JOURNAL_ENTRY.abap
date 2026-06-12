  METHOD create_journal_entry.
    TRY.
        DATA(destination) = cl_soap_destination_provider=>create_by_comm_arrangement( comm_scenario  = 'ZETR_CS_EXP_JOURNAL_ENTRY' ).

        DATA(proxy) = NEW zco_journal_entry_create_reque( destination = destination ).

        GET TIME STAMP FIELD DATA(lv_date_time).
        DATA(ls_message_header) = VALUE zbusiness_document_message_he6( creation_date_time = lv_date_time ).

        DATA(ls_req19) = VALUE zjournal_entry_create_reques19( message_header = ls_message_header
                                                               journal_entry_create_request = it_data ).
        " fill request
        DATA(request) = VALUE zjournal_entry_bulk_create_req( journal_entry_bulk_create_requ = ls_req19 ).

        proxy->journal_entry_create_request_c( EXPORTING input  = request
                                               IMPORTING output = DATA(response) ).

        " handle response
      CATCH cx_soap_destination_error INTO DATA(lx_des).

      CATCH cx_ai_system_fault INTO DATA(lx_fault).
        " handle error
    ENDTRY.

    et_response = response-journal_entry_bulk_create_conf-journal_entry_create_confirmat.

  ENDMETHOD.