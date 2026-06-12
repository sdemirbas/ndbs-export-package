  METHOD prepare_pdf.
    DATA: fs_structure TYPE REF TO data,
          lv_content   TYPE string,
          lv_structure TYPE string.

    DATA: meth  TYPE string,
          class TYPE string.

    FIELD-SYMBOLS <fs_xml> TYPE any.

    SELECT SINGLE * FROM zetr_t_exp124 WHERE button_id = @iv_button_id INTO @DATA(ls_print_operation).
    SELECT *        FROM zetr_t_exp125 WHERE button_id = @iv_button_id INTO TABLE @DATA(lt_print_parameters).
    IF ls_print_operation IS NOT INITIAL AND lt_print_parameters[] IS NOT INITIAL .

*      lv_structure =  ls_print_operation-form_str_name.

*      CREATE DATA fs_structure TYPE (lv_structure).
*      ASSIGN fs_structure->* TO <fs_xml>.

      DATA(p_tab) = VALUE abap_parmbind_tab( FOR wa IN lt_print_parameters ( name  = wa-params
                                                                             value = REF #( wa-value )
                                                                             kind  = wa-params_type ) ).
      DATA(e_tab) = VALUE abap_excpbind_tab(  ).
*
      class = VALUE #( lt_print_parameters[ 1 ]-classname    OPTIONAL ).
      meth  = VALUE #( lt_print_parameters[ 1 ]-method_name  OPTIONAL ).

      TRY.
          CALL METHOD (class)=>(meth)
            PARAMETER-TABLE p_tab
            EXCEPTION-TABLE e_tab.
          CASE sy-subrc.
            WHEN 1.
              ...
              ...
          ENDCASE.
        CATCH cx_sy_dyn_call_error INTO DATA(exc_ref).
          exc_ref->get_text(  ).
*          MESSAGE exc_ref->get_text( ) TYPE 'I'.
      ENDTRY.

      ""Move Corresponding
      TRY.
*          DATA lv_xml TYPE string.
          CALL TRANSFORMATION (ls_print_operation-form_trns_name) SOURCE (ls_print_operation-form_trns_source) = <fs_xml> result xml data(lv_xml).
          DATA(lv_string) = cl_web_http_utility=>encode_x_base64( unencoded = lv_xml ).

          call_adobe( EXPORTING iv_form_name      = ls_print_operation-form_name
                                iv_template_name  = ls_print_operation-form_name
                                iv_xml            = lv_string
                                iv_comm_scenario  = ls_print_operation-comm_scenario
                                iv_comm_system_id = ls_print_operation-comm_system_id
                                iv_service_id     = ls_print_operation-service_id
                      IMPORTING ev_pdf            = lv_content ).


          ev_response_text = lv_content.

        CATCH cx_root INTO DATA(lo_root).
          DATA(lv_message) = lo_root->get_longtext( ).
      ENDTRY.
    ENDIF.
  ENDMETHOD.