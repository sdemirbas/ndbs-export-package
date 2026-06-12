CLASS lhc_zetr_ddl_i_prn_opr DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.
    CLASS-METHODS:
      prepare_pdf IMPORTING iv_button_id     TYPE string
                            iv_export_no     TYPE zetr_e_filen
                  EXPORTING ev_pdf           TYPE string
                            ev_response_code TYPE int4
                            ev_response_text TYPE string
                  RAISING   cx_http_dest_provider_error,

      call_adobe IMPORTING iv_form_name      TYPE string
                           iv_template_name  TYPE string
                           iv_xml            TYPE string
                           iv_queue_name     TYPE string OPTIONAL
                           iv_comm_scenario  TYPE if_com_management=>ty_cscn_id
                           iv_comm_system_id TYPE if_com_management=>ty_cs_id
                           iv_service_id     TYPE if_com_management=>ty_cscn_outb_srv_id
                 EXPORTING ev_pdf            TYPE string
                           ev_response_code  TYPE int4
                           ev_response_text  TYPE string
                 RAISING   cx_http_dest_provider_error.


    TYPES: BEGIN OF ty_abap_parmbind,
             name  TYPE c LENGTH 30,
             kind  TYPE c LENGTH 1,
             value TYPE REF TO data,
           END OF ty_abap_parmbind.

    TYPES: ty_abap_parmbind_tab TYPE STANDARD TABLE OF ty_abap_parmbind WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_abap_excpbind,
             name  TYPE c LENGTH 30,
             value TYPE i,
           END OF ty_abap_excpbind.

    TYPES : ty_abap_excpbind_tab TYPE STANDARD TABLE OF ty_abap_excpbind WITH DEFAULT KEY.


    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_prn_opr RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_prn_opr IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD prepare_pdf.

    DATA: fs_structure TYPE REF TO data,
          lv_content   TYPE string.

    DATA: meth  TYPE string,
          class TYPE string,
          ptab  TYPE ty_abap_parmbind_tab,
          etab  TYPE ty_abap_excpbind_tab.

    FIELD-SYMBOLS <fs_xml> TYPE any.

    SELECT SINGLE * FROM zetr_t_exp124 WHERE button_id = @iv_button_id INTO @DATA(ls_print_operation).
    SELECT *        FROM zetr_t_exp125 WHERE button_id = @iv_button_id INTO TABLE @DATA(lt_print_parameters).
    IF ls_print_operation IS NOT INITIAL.

      CREATE DATA fs_structure TYPE (ls_print_operation-form_str_name).
      ASSIGN fs_structure->* TO <fs_xml>.

      DATA(p_tab) = VALUE abap_parmbind_tab( FOR wa IN lt_print_parameters ( name  = wa-params
                                                                             value = REF #( wa-value )
                                                                             kind  = wa-params_type ) ).
*        ptab = VALUE abap_parmbind_tab( (  name = 'aaa' value = ref #( '1'  ) kind = 'S' )  ).

*      LOOP AT lt_print_parameters ASSIGNING FIELD-SYMBOL(<fs_print_params>).
*        APPEND INITIAL LINE TO ptab ASSIGNING FIELD-SYMBOL(<fs_ptab>).
*        <fs_ptab>-name  = <fs_print_params>-params.
*        <fs_ptab>-value = REF #( <fs_print_params>-value )  .
*        <fs_ptab>-kind  = <fs_print_params>-params_type.
*      ENDLOOP.


*      etab = VALUE #( ( name = 'OTHERS' value = 4 ) ).
      DATA(e_tab) = VALUE abap_excpbind_tab(  ).
*
      TRY.
          CALL METHOD (class)=>(meth)
            PARAMETER-TABLE
            p_tab
            EXCEPTION-TABLE
            e_tab.
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
          CALL TRANSFORMATION (ls_print_operation-form_trns_name) SOURCE (ls_print_operation-form_trns_source) = <fs_xml> result xml data(lv_xml).
          DATA(lv_string) = cl_web_http_utility=>encode_x_base64( unencoded = lv_xml ).

          call_adobe( EXPORTING iv_form_name      = ls_print_operation-form_name
                                iv_template_name  = ls_print_operation-form_name
                                iv_xml            = lv_string
*                                iv_queue_name     = ls_print_operation-form_name
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

  METHOD call_adobe.
    DATA: ls_req      TYPE zetr_s_req_bod,
          ls_response TYPE zetr_s_res_bod.

    TRY.
        TRY.
            DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement( comm_scenario  = iv_comm_scenario
                                                                                      comm_system_id = iv_comm_system_id
                                                                                      service_id     = iv_service_id ).
          CATCH cx_http_dest_provider_error INTO DATA(lo_error).
        ENDTRY.

        TRY.
            DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).
          CATCH cx_web_http_client_error INTO DATA(lo_client_error).
        ENDTRY.

        DATA(lo_request) = lo_client->get_http_request( ).
        lo_request->set_header_fields( VALUE #( ( name = 'Accept'       value = 'application/json, text/plain, */*'  )
                                                ( name = 'Content-Type' value = 'application/json;charset=utf-8' ) ) ).

        ls_req-xdp_template       = |{ iv_form_name }/{ iv_template_name }|.
        ls_req-xml_data           = iv_xml.
        ls_req-form_type          = 'print'.
        ls_req-form_locale        = 'tr_TR'.
        ls_req-tagged_pdf         = 1.
        ls_req-embed_font         = 0.
        ls_req-change_not_allowed = abap_false.
        ls_req-print_not_allowed  = abap_false.

        TRY.
            DATA(lv_body) = /ui2/cl_json=>serialize( EXPORTING data        = ls_req
                                                               pretty_name = /ui2/cl_json=>pretty_mode-camel_case ).

          CATCH cx_root INTO DATA(lc_root).
            DATA(lv_message) = lc_root->get_longtext( ).
        ENDTRY.

        lo_request->set_text( EXPORTING i_text = lv_body ).

        TRY.
            DATA(lo_response) = lo_client->execute( i_method  = if_web_http_client=>post ).
          CATCH  cx_web_http_client_error INTO lo_client_error.
        ENDTRY.
        DATA(lv_response) = lo_response->get_text( ).
        DATA(ls_status)   = lo_response->get_status( ).

        TRY.
            CALL METHOD /ui2/cl_json=>deserialize
              EXPORTING
                json          = lv_response
                assoc_arrays  = abap_true
                name_mappings = VALUE #( ( json = 'fileContent' abap = 'FILECONTENT' ) )
              CHANGING
                data          = ls_response.
          CATCH cx_root INTO lc_root.
            lv_message = lc_root->get_longtext( ).
        ENDTRY.
        ev_pdf = ls_response-filecontent.

      CATCH cx_fp_fdp_error cx_fp_ads_util INTO DATA(ls_data).
        lv_message = ls_data->get_longtext( ).
    ENDTRY.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    prepare_pdf(  iv_button_id = '3' iv_export_no = '1000000014'  ).
  ENDMETHOD.

ENDCLASS.