  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'com.sap.gateway.srvd_a2x.api_billingdocument.v0001' ) ##NO_TEXT.

    def_d_billg_doc_crte_frm_sddoc( ).
    def_d_billg_doc_crte_frm_sdd_2( ).
    def_sap_message( ).
    def_billing_document_item_pa_2( ).
    def_billing_document_item_type( ).
    def_billing_document_partner_t( ).
    def_billing_document_type( ).
    def_create_from_sddocument( ).
    def_post_to_accounting( ).

  ENDMETHOD.