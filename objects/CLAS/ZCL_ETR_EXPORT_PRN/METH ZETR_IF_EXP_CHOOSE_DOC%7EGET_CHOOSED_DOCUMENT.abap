  METHOD zetr_if_exp_choose_doc~get_choosed_document.
    IF it_vbeln IS NOT INITIAL.

      LOOP AT it_vbeln ASSIGNING FIELD-SYMBOL(<fs_vbeln>).
        APPEND INITIAL LINE TO et_check_canceled ASSIGNING FIELD-SYMBOL(<fs_check_canceled>).

        <fs_check_canceled>-is_active = abap_true.
        <fs_check_canceled>-vbeln     = <fs_vbeln>-vbeln.
        <fs_check_canceled>-status    = 'Success'.
      ENDLOOP.

    ENDIF.
  ENDMETHOD.