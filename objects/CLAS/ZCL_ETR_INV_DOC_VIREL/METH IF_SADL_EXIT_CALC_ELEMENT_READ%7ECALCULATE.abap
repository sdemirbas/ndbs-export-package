  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_output TYPE STANDARD TABLE OF zetr_ddl_c_exp_inv_head_rpt.
    DATA lv_billingdocument TYPE zetr_e_vbeln.
    lt_output = CORRESPONDING #( it_original_data ).
    CHECK lt_output IS NOT INITIAL.

    TRY.

        LOOP AT lt_output ASSIGNING FIELD-SYMBOL(<ls_output>).
          lv_billingdocument = |{ <ls_output>-billingdocument }|.
          <ls_output>-documenturl = 'https://' && get_ui_url( ) && '/ui#BillingDocument-displayRedacted&/BillingDocument(' && lv_billingdocument  && ')'.
        ENDLOOP.

      CATCH cx_root INTO DATA(lx_root).

    ENDTRY.

    ct_calculated_data = CORRESPONDING #( lt_output ).
    DATA(lv_subrc) = sy-sysid.

  ENDMETHOD.