  METHOD create_reference_document.
    DATA: ls_business_data TYPE zetr_sc_billing_document=>tyt_d_billg_doc_crte_frm_sddoc,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_resource      TYPE REF TO /iwbep/if_cp_resource_function,
          lo_request       TYPE REF TO /iwbep/if_cp_request_function,
          lo_response      TYPE REF TO /iwbep/if_cp_response_function.

    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement( comm_scenario  = 'ZETR_CS_BIL_INT'
                                                                                         comm_system_id = 'ZETR_CSYS_BIL_DOCU'
                                                                                         service_id     = 'ZETR_CS_BIL_INT_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy( EXPORTING is_proxy_model_key         = VALUE #( repository_id       = 'DEFAULT'
                                                                                                                               proxy_model_id      = 'ZETR_SC_BILLING_DOCUMENT'
                                                                                                                               proxy_model_version = '0001' )
                                                                                         io_http_client             = lo_http_client
                                                                                         iv_relative_service_root   = '/sap/opu/odata4/sap/api_billingdocument/srvd_a2x/sap/billingdocument/0001' ).
        ASSERT lo_http_client IS BOUND.

        ls_business_data = VALUE #(  ).
*
*        ls_business_data = VALUE #( maint_order_conf            = is_order_conf-maint_order_conf
*                                    maint_order_conf_cntr_valu  = is_order_conf-maint_order_conf_cntr_valu
*                                    maint_order_conf_long_text  = is_order_conf-maint_order_conf_long_text ).

        " Navigate to the resource and create a request for the update operation
        lo_resource = lo_client_proxy->create_resource_for_function( iv_function_name = 'CREATE_FROM_SDDOCUMENT' )->set_parameter( is_parameter = ls_business_data ).
        lo_request  = lo_resource->create_request( ).
        lo_response = lo_request->execute( iv_http_method = /iwbep/if_cp_request_function=>gcs_http_method-post ).
        CHECK lo_response->has_business_data( ) = abap_true.

        APPEND INITIAL LINE TO et_messaging ASSIGNING FIELD-SYMBOL(<fs_messaging>) .
        <fs_messaging>-messagetext = 'Ters kayıt alınmıştır.'.
        <fs_messaging>-messagetype = 'S'.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        APPEND INITIAL LINE TO et_messaging ASSIGNING <fs_messaging> .
        <fs_messaging>-messagetext = lx_remote->get_longtext( ).
        <fs_messaging>-messagetype = 'E'.

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        APPEND INITIAL LINE TO et_messaging ASSIGNING <fs_messaging>.
        <fs_messaging>-messagetext = lx_gateway->get_text( ).
        <fs_messaging>-messagetype = 'E'.

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        APPEND INITIAL LINE TO et_messaging ASSIGNING <fs_messaging>.
        <fs_messaging>-messagetext = lx_web_http_client_error->get_text( ).
        <fs_messaging>-messagetype = 'E'.

      CATCH cx_http_dest_provider_error INTO DATA(lx_http_dest_provider_error).
        APPEND INITIAL LINE TO et_messaging ASSIGNING <fs_messaging>.
        <fs_messaging>-messagetext = lx_http_dest_provider_error->get_text( ).
        <fs_messaging>-messagetype = 'E'.
    ENDTRY.

  ENDMETHOD.