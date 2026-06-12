CLASS lhc_zetr_ddl_i_bil_doc DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS releasetoaccountingbildoc FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_i_bil_doc~releasetoaccountingbildoc.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_bil_doc RESULT result.


ENDCLASS.

CLASS lhc_zetr_ddl_i_bil_doc IMPLEMENTATION.

  METHOD releasetoaccountingbildoc.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zetr_ddl_i_export_invh DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_export_invh RESULT result.


    METHODS navigatednewpage FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_i_export_invh~navigatednewpage RESULT result.

    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_i_export_invh~getpdf RESULT result.


ENDCLASS.

CLASS lhc_zetr_ddl_i_export_invh IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD navigatednewpage.
  ENDMETHOD.

  METHOD getpdf.
    LOOP AT keys INTO DATA(ls_key).
      DATA lv_button_id TYPE string.

      lv_button_id = ls_key-%param-buttonid.

      TRY.
          zbp_etr_ddl_i_prn_opr=>call_pdf( EXPORTING iv_button_id       = lv_button_id
                                                     iv_export_no       = ls_key-fileexportnumber
                                                     iv_billingdocument = ls_key-billingdocument
                                           IMPORTING ev_pdf             = DATA(lv_pdf)
                                                     ev_response_code   = DATA(lv_response_code)
                                                     ev_response_text   = DATA(lv_response_text) ).

          result = VALUE #( ( billingdocument  = ls_key-billingdocument
                              fileexportnumber = ls_key-fileexportnumber
                              %param-content   = lv_pdf  ) ) .

        CATCH cx_http_dest_provider_error.
          "handle exception
      ENDTRY.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zetr_ddl_i_exp_head DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.
    METHODS save_modified  REDEFINITION .

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zetr_ddl_i_exp_head IMPLEMENTATION.


  METHOD adjust_numbers.
  ENDMETHOD.

  METHOD save_modified.

    DATA: lt_main        TYPE TABLE OF zetr_t_r101,
          ls_update_data TYPE zetr_t_r101,
          lt_exporttext  TYPE TABLE OF zetr_t_exp123,
          lt_dele        TYPE RANGE OF zetr_e_filen,
          lv_filen       TYPE zetr_e_filen.

    DATA: tb_struct TYPE REF TO cl_abap_structdescr,
          tb_comp   TYPE        abap_component_tab.

    FIELD-SYMBOLS: <fs_name>         TYPE any,
                   <fs_update_data>  TYPE any,
                   <fs_export_value> TYPE any.

    IF create-zetr_ddl_i_exp_head IS NOT INITIAL.

      SELECT * FROM zetr_ddl_c_txt_typ WHERE language = @sy-langu INTO TABLE @DATA(lt_texts).
      SELECT * FROM zetr_t_exp122                                 INTO TABLE @DATA(lt_bank_detail).

      LOOP AT create-zetr_ddl_i_exp_head INTO DATA(ls_create).
        APPEND INITIAL LINE TO lt_main ASSIGNING FIELD-SYMBOL(<ls_main>).
        MOVE-CORRESPONDING ls_create TO <ls_main>.
        lv_filen = ls_create-filen.

        <ls_main>-erdat = cl_abap_context_info=>get_system_date( ).
        <ls_main>-erzet = cl_abap_context_info=>get_system_time( ).
        TRY.
            <ls_main>-ernam = cl_abap_context_info=>get_user_business_partner_id( ).
          CATCH cx_abap_context_info_error.
            "handle exception
        ENDTRY.
      ENDLOOP.



      LOOP AT lt_texts ASSIGNING FIELD-SYMBOL(<fs_text>).
        APPEND INITIAL LINE TO lt_exporttext ASSIGNING FIELD-SYMBOL(<fs_exporttext>).
        <fs_exporttext>-filen      = lv_filen.
        <fs_exporttext>-objecttype = <fs_text>-textkey.
      ENDLOOP.

      IF lt_main IS NOT INITIAL.
        INSERT zetr_t_r101 FROM TABLE @lt_main.
      ENDIF.

      IF lt_exporttext IS NOT INITIAL.
        INSERT zetr_t_exp123 FROM TABLE @lt_exporttext.
      ENDIF.

      APPEND VALUE #( %key = VALUE #( filen = lv_filen )
                      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                    text     = |{ lv_filen } yaratılmıştır.| ) ) TO reported-zetr_ddl_i_exp_head.
    ENDIF.

    IF update-zetr_ddl_i_exp_head IS NOT INITIAL.
      DATA(ls_exp_header) = VALUE #( update-zetr_ddl_i_exp_head[ 1 ] OPTIONAL ).

      SELECT SINGLE * FROM zetr_t_r101 WHERE filen = @ls_exp_header-filen INTO @DATA(ls_r101) .

      LOOP AT update-zetr_ddl_i_exp_head INTO DATA(ls_update).
        tb_struct ?= cl_abap_typedescr=>describe_by_data( ls_update-%control ).

        LOOP AT tb_struct->components ASSIGNING FIELD-SYMBOL(<fs_components>).
          ASSIGN COMPONENT <fs_components>-name OF STRUCTURE ls_update-%control TO <fs_name>.

          IF <fs_name> = if_abap_behv=>mk-on.
            ASSIGN COMPONENT <fs_components>-name OF STRUCTURE ls_update TO <fs_update_data>.
            ASSIGN COMPONENT <fs_components>-name OF STRUCTURE ls_r101   TO <fs_export_value>.

*            IF <fs_components>-name = 'BANKID' AND <fs_update_data> IS INITIAL.
*              ls_r101-bankl = ''.
*              ls_r101-iban   = ''.
*            ENDIF.
            <fs_export_value> = <fs_update_data>.
          ENDIF.

        ENDLOOP.

      ENDLOOP.

      IF ls_r101 IS NOT INITIAL.


        IF ls_r101-iban IS INITIAL OR ls_r101-bankl IS INITIAL OR ls_r101-bankid IS INITIAL.
          ls_r101-bankl  = ''.
          ls_r101-iban   = ''.
          ls_r101-bankid = ''.
        ENDIF.

        ls_r101-aedat = cl_abap_context_info=>get_system_date( ).
        ls_r101-aezet = cl_abap_context_info=>get_system_time( ).
        TRY.
            ls_r101-aenam = cl_abap_context_info=>get_user_business_partner_id( ).
          CATCH cx_abap_context_info_error.
            "handle exception
        ENDTRY.

        MODIFY zetr_t_r101 FROM @ls_r101.
      ENDIF.

      APPEND VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                    text     = | { ls_r101-filen } numaralı dosya güncellenmiştir.| )
                                                    filen    = lv_filen  ) TO reported-zetr_ddl_i_exp_head.
    ENDIF.


    IF update-zetr_ddl_i_exp_txt IS NOT INITIAL.
      CLEAR lt_exporttext.

      LOOP AT update-zetr_ddl_i_exp_txt ASSIGNING FIELD-SYMBOL(<fs_txt>).
        APPEND INITIAL LINE TO lt_exporttext ASSIGNING FIELD-SYMBOL(<fs_export_new>).
        <fs_export_new>-text      = <fs_txt>-text.
        <fs_export_new>-filen     = <fs_txt>-filen.
        <fs_export_new>-objecttype = <fs_txt>-objecttype.
      ENDLOOP.


      MODIFY zetr_t_exp123 FROM TABLE @lt_exporttext.

    ENDIF.


    IF delete-zetr_ddl_i_exp_head IS NOT INITIAL.
      DATA(ls_exp_header_deleted) = VALUE #( delete-zetr_ddl_i_exp_head[ 1 ] OPTIONAL ).


      IF ls_exp_header_deleted-filen IS NOT INITIAL.
        UPDATE zetr_t_r101
           SET isdeleted = 'X'
         WHERE filen = @ls_exp_header_deleted-filen.
      ENDIF.

      APPEND VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                    text     = | { ls_exp_header_deleted-filen } numaralı dosya silinmiştir.| )
                                                    filen    = lv_filen ) TO reported-zetr_ddl_i_exp_head.


    ENDIF.

    IF delete-zetr_ddl_i_export_invh IS NOT INITIAL.
      DATA(ls_exp_invoice_deleted) = VALUE #( delete-zetr_ddl_i_export_invh[ 1 ] OPTIONAL ).

      DELETE FROM zetr_t_r102
            WHERE filen = @ls_exp_invoice_deleted-fileexportnumber
              AND vbeln = @ls_exp_invoice_deleted-billingdocument.

      DELETE FROM zetr_t_r103
            WHERE filen = @ls_exp_invoice_deleted-fileexportnumber
              AND vbeln = @ls_exp_invoice_deleted-billingdocument.



      APPEND VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                    text     = | { ls_exp_invoice_deleted-billingdocument } numaralı belge silinmiştir.| )
                                                    filen    = lv_filen ) TO reported-zetr_ddl_i_exp_head.

    ENDIF.

    IF delete-zetr_ddl_i_export_invi IS NOT INITIAL.
      DATA(ls_exp_invoice_item_deleted) = VALUE #( delete-zetr_ddl_i_export_invi[ 1 ] OPTIONAL ).

      SELECT SINGLE *
               FROM zetr_t_r103
              WHERE filen = @ls_exp_invoice_item_deleted-filen
                AND vbeln = @ls_exp_invoice_item_deleted-vbeln
                AND posnr <> @ls_exp_invoice_item_deleted-billingdocumentitem
               INTO @DATA(ls_other_item).

      IF ls_other_item IS INITIAL.
        DELETE FROM zetr_t_r102
              WHERE filen = @ls_exp_invoice_item_deleted-filen
                AND vbeln = @ls_exp_invoice_item_deleted-vbeln.

      ENDIF.
      DELETE FROM zetr_t_r103
            WHERE filen = @ls_exp_invoice_item_deleted-filen
              AND vbeln = @ls_exp_invoice_item_deleted-vbeln
              AND posnr = @ls_exp_invoice_item_deleted-billingdocumentitem.

      APPEND VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                      text     = | { ls_exp_invoice_item_deleted-vbeln } / { ls_exp_invoice_item_deleted-billingdocumentitem } numaralı belge silinmiştir.| )
                                                      filen    = lv_filen ) TO reported-zetr_ddl_i_exp_head.
    ENDIF.

  ENDMETHOD.


ENDCLASS.

CLASS lhc_zetr_ddl_i_exp_head DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_exp_head RESULT result.
    METHODS releasetoaccounting FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_i_exp_head~releasetoaccounting.
    METHODS validategeneral FOR VALIDATE ON SAVE
      IMPORTING keys FOR zetr_ddl_i_exp_head~validategeneral.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zetr_ddl_i_exp_head.

ENDCLASS.

CLASS lhc_zetr_ddl_i_exp_head IMPLEMENTATION.

  METHOD earlynumbering_create.
    DATA(ls_mapped)   = mapped.
    DATA(ls_entities) = entities.
    DATA lv_filen   TYPE zetr_e_filen.
    DATA(lv_nr_range_nr) = VALUE char2( ).

    IF ls_entities IS NOT INITIAL.

      SELECT *
        FROM zetr_ddl_i_doc_type
     FOR ALL ENTRIES IN @ls_entities
       WHERE exporttype = @ls_entities-expty
        INTO TABLE @DATA(lt_doc_type).
      IF lt_doc_type IS NOT INITIAL.
        lv_nr_range_nr = lt_doc_type[ 1 ]-numki.
      ELSE.
        lv_nr_range_nr = '10'.
      ENDIF.

    ENDIF.

    TRY.
        cl_numberrange_runtime=>number_get( EXPORTING nr_range_nr       = lv_nr_range_nr
                                                      object            = 'ZETR_EXP'
                                            IMPORTING number            = DATA(number_range_key)
                                                     returncode         = DATA(number_range_return_code)
                                                      returned_quantity = DATA(number_range_returned_quantity) ).

        lv_filen = |{ number_range_key ALPHA = OUT }|.

      CATCH cx_nr_object_not_found cx_number_ranges INTO DATA(lo_number).
        APPEND VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text     = lo_number->get_text( ) ) ) TO reported-zetr_ddl_i_exp_head.
    ENDTRY.



    mapped-zetr_ddl_i_exp_head = VALUE #( ( %cid = entities[ 1 ]-%cid
                                           filen = lv_filen ) ).

  ENDMETHOD.
  METHOD get_instance_authorizations.


  ENDMETHOD.

  METHOD releasetoaccounting.
    DATA(lv_deneme) = 1.
  ENDMETHOD.

  METHOD validategeneral.

    DATA lt_messages    TYPE zetr_tt_messages.
    DATA ls_method_data TYPE zetr_ddl_i_exp_head.

    READ ENTITIES OF zetr_ddl_i_exp_head IN LOCAL MODE
      ENTITY zetr_ddl_i_exp_head
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data).

    DATA(lo_instance) = zetr_if_validation=>get_instance(  ).
    LOOP AT lt_data INTO DATA(ls_data).

      ls_method_data = CORRESPONDING #( ls_data ).

      CALL BADI lo_instance->check_validation_properties
        EXPORTING
          is_data  = ls_method_data
        IMPORTING
          messages = lt_messages.

    ENDLOOP.


    LOOP AT lt_messages ASSIGNING FIELD-SYMBOL(<fs_messages>).

      DATA ls_reported LIKE LINE OF reported-zetr_ddl_i_exp_head.
      DATA(lv_component) = |%element-{ <fs_messages>-field }|.

      FIELD-SYMBOLS <fs_element> TYPE any.

      ASSIGN COMPONENT lv_component
             OF STRUCTURE ls_reported
             TO <fs_element>.

      IF <fs_element> IS ASSIGNED.

        <fs_element> = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = <fs_messages>-message
        ).

      ELSE.
        " Fallback: alan bulunamazsa generic message ver
        ls_reported-%msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-information
            text     = <fs_messages>-message
        ).
      ENDIF.

      APPEND ls_reported TO reported-zetr_ddl_i_exp_head.

    ENDLOOP.


*    LOOP AT lt_messages ASSIGNING FIELD-SYMBOL(<fs_messages>).
*      DATA ls_reported TYPE zetr_ddl_i_exp_head.
*
*      FIELD-SYMBOLS:
*        <fs_element> TYPE any.
*
*      ASSIGN COMPONENT |%element-{ <fs_messages>-field }|
*             OF STRUCTURE ls_reported
*             TO <fs_element>.
*
*      IF sy-subrc = 0.
*        <fs_element> = new_message_with_text(
*            severity = if_abap_behv_message=>severity-error
*            text     = <fs_messages>-message
*        ).
*      ENDIF.
*
*
*
*      APPEND ls_reported TO  reported-zetr_ddl_i_exp_head.
*    ENDLOOP.

  ENDMETHOD.

ENDCLASS.