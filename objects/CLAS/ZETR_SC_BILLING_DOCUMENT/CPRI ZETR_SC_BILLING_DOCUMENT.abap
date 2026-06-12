  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define D_BillgDocCrteFrmSDDocRefPP</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_d_billg_doc_crte_frm_sddoc RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define D_BillgDocCrteFrmSDDocCtrlPP</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_d_billg_doc_crte_frm_sdd_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define SAP__Message</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_sap_message RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define BillingDocumentItemPartner_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_billing_document_item_pa_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define BillingDocumentItem_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_billing_document_item_type RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define BillingDocumentPartner_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_billing_document_partner_t RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define BillingDocument_Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_billing_document_type RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define CreateFromSDDocument</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_create_from_sddocument RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define PostToAccounting</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_post_to_accounting RAISING /iwbep/cx_gateway.
