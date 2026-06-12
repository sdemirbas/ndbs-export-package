  METHOD call_pdf.
    DATA: lo_badi  TYPE REF TO zetr_if_exp_prn.    " BAdI arayüz tipi
    DATA lv_button TYPE c.

    lv_button = iv_button_id.

    TRY.
        DATA(lo_instance) = zetr_export=>get_instance(  ).

        IF lo_instance IS BOUND.
          CALL BADI lo_instance->get_pdf
            EXPORTING
              iv_billingdocument = iv_billingdocument
              iv_button          = lv_button
              iv_fileexportno    = iv_export_no
              iv_dummy           = ''
            IMPORTING
              ev_document_value  = ev_pdf.
        ENDIF.

      CATCH cx_root.
    ENDTRY.

  ENDMETHOD.