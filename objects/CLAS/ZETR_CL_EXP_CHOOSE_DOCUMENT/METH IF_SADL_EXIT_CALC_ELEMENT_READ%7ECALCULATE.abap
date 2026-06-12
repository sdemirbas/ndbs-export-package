  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA lo_badi            TYPE REF TO zetr_if_exp_choose.    " BAdI arayüz tipi
    DATA(lt_vbeln)        = VALUE  zetr_tt_document( ).
    DATA(lt_export_vbeln) = VALUE zetr_tt_document_active( ).
    DATA lt_output          TYPE STANDARD TABLE OF zetr_ddl_c_exp_invoice_p.

    lt_output = CORRESPONDING #( it_original_data ).
    CHECK lt_output IS NOT INITIAL.
    TRY.
        DATA(lo_instance) = zetr_if_exp_choose=>get_instance(  ).


        LOOP AT lt_output ASSIGNING FIELD-SYMBOL(<fs_output>).
          APPEND INITIAL LINE TO lt_vbeln ASSIGNING FIELD-SYMBOL(<fs_vbeln>).
          <fs_vbeln>-vbeln = |{ <fs_output>-billingdocument ALPHA = IN }|.
        ENDLOOP.

        " IF zetr_if_exp_choose IS BOUND.
        CALL BADI lo_instance->get_choosed_document
          EXPORTING
            it_vbeln          = lt_vbeln
          IMPORTING
            et_check_canceled = lt_export_vbeln.
        "  ENDIF.

        LOOP AT lt_output ASSIGNING <fs_output>.
          <fs_output>-canceledbyorderprj       = VALUE #( lt_export_vbeln[ vbeln = <fs_output>-billingdocument ]-is_active OPTIONAL ).
          <fs_output>-canceledbyorderprjstatus = VALUE #( lt_export_vbeln[ vbeln = <fs_output>-billingdocument ]-status OPTIONAL ).
        ENDLOOP.

        ct_calculated_data = CORRESPONDING #( lt_output ).

      CATCH cx_root INTO DATA(lx_root).
    ENDTRY.
    DATA(lv_subrc) = sy-sysid.

  ENDMETHOD.