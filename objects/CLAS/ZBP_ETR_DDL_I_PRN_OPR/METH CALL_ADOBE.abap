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