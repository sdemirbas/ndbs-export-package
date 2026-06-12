"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>com.sap.gateway.srvd_a2x.api_billingdocument.v0001</em>
CLASS zetr_sc_billing_document DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">Types for primitive collection fields</p>
      BEGIN OF tys_types_for_prim_colls,
        "! additionalTargets
        "! Used for TYS_SAP_MESSAGE-ADDITIONAL_TARGETS
        additional_targets TYPE string,
      END OF tys_types_for_prim_colls.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of D_BILLG_DOC_CRTE_FRM_SDDOC</p>
      BEGIN OF tys_value_controls_1,
        "! BILLING_DOCUMENT_DATE
        billing_document_date TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_1.

    TYPES:
      "! <p class="shorttext synchronized">D_BillgDocCrteFrmSDDocRefPP</p>
      BEGIN OF tys_d_billg_doc_crte_frm_sddoc,
        "! <em>Value Control Structure</em>
        value_controls        TYPE tys_value_controls_1,
        "! SDDocument
        sddocument            TYPE c LENGTH 10,
        "! BillingDocumentType
        billing_document_type TYPE c LENGTH 4,
        "! BillingDocumentDate
        billing_document_date TYPE datn,
        "! DestinationCountry
        destination_country   TYPE c LENGTH 3,
        "! SalesOrganization
        sales_organization    TYPE c LENGTH 4,
        "! SDDocumentCategory
        sddocument_category   TYPE c LENGTH 4,
      END OF tys_d_billg_doc_crte_frm_sddoc,
      "! <p class="shorttext synchronized">List of D_BillgDocCrteFrmSDDocRefPP</p>
      tyt_d_billg_doc_crte_frm_sddoc TYPE STANDARD TABLE OF tys_d_billg_doc_crte_frm_sddoc WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of D_BILLG_DOC_CRTE_FRM_SDD_2</p>
      BEGIN OF tys_value_controls_2,
        "! DEFAULT_BILLING_DOCUMENT_D
        default_billing_document_d TYPE /iwbep/v4_value_control,
        "! CUT_OFF_BILLING_DOCUMENT_D
        cut_off_billing_document_d TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_2.

    TYPES:
      "! <p class="shorttext synchronized">D_BillgDocCrteFrmSDDocCtrlPP</p>
      BEGIN OF tys_d_billg_doc_crte_frm_sdd_2,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_2,
        "! DefaultBillingDocumentDate
        default_billing_document_d TYPE datn,
        "! DefaultBillingDocumentType
        default_billing_document_t TYPE c LENGTH 4,
        "! AutomPostingToAcctgIsDisabled
        autom_posting_to_acctg_is  TYPE abap_bool,
        "! CutOffBillingDocumentDate
        cut_off_billing_document_d TYPE datn,
      END OF tys_d_billg_doc_crte_frm_sdd_2,
      "! <p class="shorttext synchronized">List of D_BillgDocCrteFrmSDDocCtrlPP</p>
      tyt_d_billg_doc_crte_frm_sdd_2 TYPE STANDARD TABLE OF tys_d_billg_doc_crte_frm_sdd_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of SAP_MESSAGE</p>
      BEGIN OF tys_value_controls_3,
        "! TARGET
        target       TYPE /iwbep/v4_value_control,
        "! LONGTEXT_URL
        longtext_url TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_3.

    TYPES:
      "! <p class="shorttext synchronized">SAP__Message</p>
      BEGIN OF tys_sap_message,
        "! <em>Value Control Structure</em>
        value_controls     TYPE tys_value_controls_3,
        "! code
        code               TYPE string,
        "! message
        message            TYPE string,
        "! target
        target             TYPE string,
        "! additionalTargets
        additional_targets TYPE STANDARD TABLE OF tys_types_for_prim_colls-additional_targets WITH DEFAULT KEY,
        "! transition
        transition         TYPE abap_bool,
        "! numericSeverity
        numeric_severity   TYPE int1,
        "! longtextUrl
        longtext_url       TYPE string,
      END OF tys_sap_message,
      "! <p class="shorttext synchronized">List of SAP__Message</p>
      tyt_sap_message TYPE STANDARD TABLE OF tys_sap_message WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of BILLING_DOCUMENT_TYPE</p>
      BEGIN OF tys_value_controls_4,
        "! CREATION_DATE
        creation_date             TYPE /iwbep/v4_value_control,
        "! LAST_CHANGE_DATE
        last_change_date          TYPE /iwbep/v4_value_control,
        "! LAST_CHANGE_DATE_TIME
        last_change_date_time     TYPE /iwbep/v4_value_control,
        "! BILLING_DOCUMENT_DATE
        billing_document_date     TYPE /iwbep/v4_value_control,
        "! FIXED_VALUE_DATE
        fixed_value_date          TYPE /iwbep/v4_value_control,
        "! EXCHANGE_RATE_DATE
        exchange_rate_date        TYPE /iwbep/v4_value_control,
        "! INVOICE_LIST_BILLING_DATE
        invoice_list_billing_date TYPE /iwbep/v4_value_control,
        "! ITEM
        item                      TYPE /iwbep/v4_value_control,
        "! PARTNER
        partner                   TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_4.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of BILLING_DOCUMENT_PARTNER_T</p>
      BEGIN OF tys_value_controls_5,
        "! CUSTOMER
        customer                   TYPE /iwbep/v4_value_control,
        "! SUPPLIER
        supplier                   TYPE /iwbep/v4_value_control,
        "! PERSONNEL
        personnel                  TYPE /iwbep/v4_value_control,
        "! CONTACT_PERSON
        contact_person             TYPE /iwbep/v4_value_control,
        "! BUSINESS_PARTNER_ADDRESS_U
        business_partner_address_u TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_5.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of BILLING_DOCUMENT_ITEM_PA_2</p>
      BEGIN OF tys_value_controls_6,
        "! CUSTOMER
        customer                   TYPE /iwbep/v4_value_control,
        "! SUPPLIER
        supplier                   TYPE /iwbep/v4_value_control,
        "! PERSONNEL
        personnel                  TYPE /iwbep/v4_value_control,
        "! CONTACT_PERSON
        contact_person             TYPE /iwbep/v4_value_control,
        "! BUSINESS_PARTNER_ADDRESS_U
        business_partner_address_u TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_6.

    TYPES:
      "! <p class="shorttext synchronized">Value Control Structure of BILLING_DOCUMENT_ITEM_TYPE</p>
      BEGIN OF tys_value_controls_7,
        "! CREATION_DATE
        creation_date              TYPE /iwbep/v4_value_control,
        "! SERVICES_RENDERED_DATE
        services_rendered_date     TYPE /iwbep/v4_value_control,
        "! PRICING_DATE
        pricing_date               TYPE /iwbep/v4_value_control,
        "! PRICE_DETN_EXCHANGE_RATE_D
        price_detn_exchange_rate_d TYPE /iwbep/v4_value_control,
        "! TAX_RATE_VALIDITY_START_DA
        tax_rate_validity_start_da TYPE /iwbep/v4_value_control,
        "! BILLING_PERIOD_OF_PERF_STA
        billing_period_of_perf_sta TYPE /iwbep/v4_value_control,
        "! BILLING_PERIOD_OF_PERF_END
        billing_period_of_perf_end TYPE /iwbep/v4_value_control,
        "! HIGHER_LEVEL_ITEM
        higher_level_item          TYPE /iwbep/v4_value_control,
        "! ITEM_PARTNER
        item_partner               TYPE /iwbep/v4_value_control,
      END OF tys_value_controls_7.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of action CreateFromSDDocument</p>
      "! <em>with the internal name</em> CREATE_FROM_SDDOCUMENT
      BEGIN OF tys_parameters_1,
        "! _Control
        control   TYPE tys_d_billg_doc_crte_frm_sdd_2,
        "! _Reference
        reference TYPE tyt_d_billg_doc_crte_frm_sddoc,
      END OF tys_parameters_1,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_1</p>
      tyt_parameters_1 TYPE STANDARD TABLE OF tys_parameters_1 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">BillingDocumentItemPartner_Type</p>
      BEGIN OF tys_billing_document_item_pa_2,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_6,
        "! <em>Key property</em> BillingDocument
        billing_document           TYPE c LENGTH 10,
        "! <em>Key property</em> BillingDocumentItem
        billing_document_item      TYPE c LENGTH 6,
        "! <em>Key property</em> PartnerFunction
        partner_function           TYPE c LENGTH 2,
        "! Customer
        customer                   TYPE c LENGTH 10,
        "! Supplier
        supplier                   TYPE c LENGTH 10,
        "! Personnel
        personnel                  TYPE c LENGTH 8,
        "! ContactPerson
        contact_person             TYPE c LENGTH 10,
        "! ReferenceBusinessPartner
        reference_business_partner TYPE c LENGTH 10,
        "! BusinessPartnerAddressUUID
        business_partner_address_u TYPE sysuuid_x16,
        "! PartnerIsSpecificForSDDocItem
        partner_is_specific_for_sd TYPE abap_bool,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_billing_document_item_pa_2,
      "! <p class="shorttext synchronized">List of BillingDocumentItemPartner_Type</p>
      tyt_billing_document_item_pa_2 TYPE STANDARD TABLE OF tys_billing_document_item_pa_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">BillingDocumentItem_Type</p>
      BEGIN OF tys_billing_document_item_type,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_7,
        "! <em>Key property</em> BillingDocument
        billing_document           TYPE c LENGTH 10,
        "! <em>Key property</em> BillingDocumentItem
        billing_document_item      TYPE c LENGTH 6,
        "! SalesDocumentItemCategory
        sales_document_item_catego TYPE c LENGTH 4,
        "! SalesDocumentItemType
        sales_document_item_type   TYPE c LENGTH 1,
        "! ReturnItemProcessingType
        return_item_processing_typ TYPE c LENGTH 1,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! CreationDate
        creation_date              TYPE datn,
        "! CreationTime
        creation_time              TYPE timn,
        "! ReferenceLogicalSystem
        reference_logical_system   TYPE c LENGTH 10,
        "! OrganizationDivision
        organization_division      TYPE c LENGTH 2,
        "! Division
        division                   TYPE c LENGTH 2,
        "! SalesOffice
        sales_office               TYPE c LENGTH 4,
        "! Product
        product                    TYPE c LENGTH 18,
        "! OriginallyRequestedMaterial
        originally_requested_mater TYPE c LENGTH 18,
        "! InternationalArticleNumber
        international_article_numb TYPE c LENGTH 18,
        "! PricingReferenceMaterial
        pricing_reference_material TYPE c LENGTH 18,
        "! Batch
        batch                      TYPE c LENGTH 10,
        "! ProductGroup
        product_group              TYPE c LENGTH 9,
        "! AdditionalMaterialGroup1
        additional_material_group  TYPE c LENGTH 3,
        "! AdditionalMaterialGroup2
        additional_material_grou_2 TYPE c LENGTH 3,
        "! AdditionalMaterialGroup3
        additional_material_grou_3 TYPE c LENGTH 3,
        "! AdditionalMaterialGroup4
        additional_material_grou_4 TYPE c LENGTH 3,
        "! AdditionalMaterialGroup5
        additional_material_grou_5 TYPE c LENGTH 3,
        "! ProductConfiguration
        product_configuration      TYPE c LENGTH 18,
        "! Plant
        plant                      TYPE c LENGTH 4,
        "! StorageLocation
        storage_location           TYPE c LENGTH 4,
        "! PlantRegion
        plant_region               TYPE c LENGTH 3,
        "! PlantCounty
        plant_county               TYPE c LENGTH 3,
        "! PlantCity
        plant_city                 TYPE c LENGTH 4,
        "! MaterialDeterminationType
        material_determination_typ TYPE c LENGTH 1,
        "! SoldProduct
        sold_product               TYPE c LENGTH 18,
        "! BillingDocumentItemText
        billing_document_item_text TYPE c LENGTH 40,
        "! ServicesRenderedDate
        services_rendered_date     TYPE datn,
        "! BillingQuantity
        billing_quantity           TYPE p LENGTH 7 DECIMALS 3,
        "! BillingQuantityUnitSAPCode
        billing_quantity_unit_sapc TYPE c LENGTH 3,
        "! BillingQuantityUnitISOCode
        billing_quantity_unit_isoc TYPE c LENGTH 3,
        "! BillingQuantityInBaseUnit
        billing_quantity_in_base_u TYPE p LENGTH 7 DECIMALS 3,
        "! BaseUnitSAPCode
        base_unit_sapcode          TYPE c LENGTH 3,
        "! BaseUnitISOCode
        base_unit_isocode          TYPE c LENGTH 3,
        "! MRPRequiredQuantityInBaseUnit
        mrprequired_quantity_in_ba TYPE p LENGTH 7 DECIMALS 3,
        "! BillingToBaseQuantityDnmntr
        billing_to_base_quantity_d TYPE p LENGTH 3 DECIMALS 0,
        "! BillingToBaseQuantityNmrtr
        billing_to_base_quantity_n TYPE p LENGTH 3 DECIMALS 0,
        "! ItemGrossWeight
        item_gross_weight          TYPE p LENGTH 8 DECIMALS 3,
        "! ItemNetWeight
        item_net_weight            TYPE p LENGTH 8 DECIMALS 3,
        "! ItemWeightUnitSAPCode
        item_weight_unit_sapcode   TYPE c LENGTH 3,
        "! ItemWeightUnitISOCode
        item_weight_unit_isocode   TYPE c LENGTH 3,
        "! ItemVolume
        item_volume                TYPE p LENGTH 8 DECIMALS 3,
        "! ItemVolumeUnitSAPCode
        item_volume_unit_sapcode   TYPE c LENGTH 3,
        "! ItemVolumeUnitISOCode
        item_volume_unit_isocode   TYPE c LENGTH 3,
        "! BillingPlanRule
        billing_plan_rule          TYPE c LENGTH 1,
        "! BillingPlan
        billing_plan               TYPE c LENGTH 10,
        "! BillingPlanItem
        billing_plan_item          TYPE c LENGTH 6,
        "! NetAmount
        net_amount                 TYPE decfloat16,
        "! TransactionCurrency
        transaction_currency       TYPE c LENGTH 3,
        "! GrossAmount
        gross_amount               TYPE decfloat16,
        "! PricingDate
        pricing_date               TYPE datn,
        "! AbsltPriceDetnExchangeRate
        abslt_price_detn_exchange  TYPE p LENGTH 5 DECIMALS 5,
        "! PriceDetnExchRateIsIndrctQtan
        price_detn_exch_rate_is_in TYPE abap_bool,
        "! PriceDetnExchangeRateDate
        price_detn_exchange_rate_d TYPE datn,
        "! PricingScaleQuantityInBaseUnit
        pricing_scale_quantity_in  TYPE p LENGTH 7 DECIMALS 3,
        "! TaxAmount
        tax_amount                 TYPE decfloat16,
        "! CostAmount
        cost_amount                TYPE decfloat16,
        "! Subtotal1Amount
        subtotal_1_amount          TYPE decfloat16,
        "! Subtotal2Amount
        subtotal_2_amount          TYPE decfloat16,
        "! Subtotal3Amount
        subtotal_3_amount          TYPE decfloat16,
        "! Subtotal4Amount
        subtotal_4_amount          TYPE decfloat16,
        "! Subtotal5Amount
        subtotal_5_amount          TYPE decfloat16,
        "! Subtotal6Amount
        subtotal_6_amount          TYPE decfloat16,
        "! StatisticalValueControl
        statistical_value_control  TYPE c LENGTH 1,
        "! CashDiscountIsDeductible
        cash_discount_is_deductibl TYPE abap_bool,
        "! CustomerConditionGroup1
        customer_condition_group_1 TYPE c LENGTH 2,
        "! CustomerConditionGroup2
        customer_condition_group_2 TYPE c LENGTH 2,
        "! CustomerConditionGroup3
        customer_condition_group_3 TYPE c LENGTH 2,
        "! CustomerConditionGroup4
        customer_condition_group_4 TYPE c LENGTH 2,
        "! CustomerConditionGroup5
        customer_condition_group_5 TYPE c LENGTH 2,
        "! ManualPriceChangeType
        manual_price_change_type   TYPE c LENGTH 1,
        "! MaterialPricingGroup
        material_pricing_group     TYPE c LENGTH 2,
        "! AbsltStatisticsExchangeRate
        abslt_statistics_exchange  TYPE p LENGTH 5 DECIMALS 5,
        "! StatisticsExchRateIsIndrctQtan
        statistics_exch_rate_is_in TYPE abap_bool,
        "! MainItemPricingRefMaterial
        main_item_pricing_ref_mate TYPE c LENGTH 18,
        "! MainItemMaterialPricingGroup
        main_item_material_pricing TYPE c LENGTH 2,
        "! TimeSheetOvertimeCategory
        time_sheet_overtime_catego TYPE c LENGTH 4,
        "! DepartureCountry
        departure_country          TYPE c LENGTH 3,
        "! TaxJurisdiction
        tax_jurisdiction           TYPE c LENGTH 15,
        "! ProductTaxClassification1
        product_tax_classification TYPE c LENGTH 1,
        "! ProductTaxClassification2
        product_tax_classificati_2 TYPE c LENGTH 1,
        "! ProductTaxClassification3
        product_tax_classificati_3 TYPE c LENGTH 1,
        "! ProductTaxClassification4
        product_tax_classificati_4 TYPE c LENGTH 1,
        "! ProductTaxClassification5
        product_tax_classificati_5 TYPE c LENGTH 1,
        "! ProductTaxClassification6
        product_tax_classificati_6 TYPE c LENGTH 1,
        "! ProductTaxClassification7
        product_tax_classificati_7 TYPE c LENGTH 1,
        "! ProductTaxClassification8
        product_tax_classificati_8 TYPE c LENGTH 1,
        "! ProductTaxClassification9
        product_tax_classificati_9 TYPE c LENGTH 1,
        "! TaxCode
        tax_code                   TYPE c LENGTH 2,
        "! TaxRateValidityStartDate
        tax_rate_validity_start_da TYPE datn,
        "! EligibleAmountForCashDiscount
        eligible_amount_for_cash_d TYPE decfloat16,
        "! BusinessArea
        business_area              TYPE c LENGTH 4,
        "! ProfitCenter
        profit_center              TYPE c LENGTH 10,
        "! WBSElementExternalID
        wbselement_external_id     TYPE c LENGTH 24,
        "! ProviderContract
        provider_contract          TYPE c LENGTH 20,
        "! ProviderContractItem
        provider_contract_item     TYPE c LENGTH 6,
        "! BillingPeriodOfPerfStartDate
        billing_period_of_perf_sta TYPE datn,
        "! BillingPeriodOfPerfEndDate
        billing_period_of_perf_end TYPE datn,
        "! ControllingArea
        controlling_area           TYPE c LENGTH 4,
        "! CostCenter
        cost_center                TYPE c LENGTH 10,
        "! MatlAccountAssignmentGroup
        matl_account_assignment_gr TYPE c LENGTH 2,
        "! ReferenceSDDocument
        reference_sddocument       TYPE c LENGTH 10,
        "! ReferenceSDDocumentItem
        reference_sddocument_item  TYPE c LENGTH 6,
        "! ReferenceSDDocumentCategory
        reference_sddocument_categ TYPE c LENGTH 4,
        "! SalesDocument
        sales_document             TYPE c LENGTH 10,
        "! SalesDocumentItem
        sales_document_item        TYPE c LENGTH 6,
        "! SalesSDDocumentCategory
        sales_sddocument_category  TYPE c LENGTH 4,
        "! HigherLevelItem
        higher_level_item          TYPE c LENGTH 6,
        "! BillingDocumentItemInPartSgmt
        billing_document_item_in_p TYPE c LENGTH 6,
        "! SalesGroup
        sales_group                TYPE c LENGTH 3,
        "! AdditionalCustomerGroup1
        additional_customer_group  TYPE c LENGTH 3,
        "! AdditionalCustomerGroup2
        additional_customer_grou_2 TYPE c LENGTH 3,
        "! AdditionalCustomerGroup3
        additional_customer_grou_3 TYPE c LENGTH 3,
        "! AdditionalCustomerGroup4
        additional_customer_grou_4 TYPE c LENGTH 3,
        "! AdditionalCustomerGroup5
        additional_customer_grou_5 TYPE c LENGTH 3,
        "! SDDocumentReason
        sddocument_reason          TYPE c LENGTH 3,
        "! ItemIsRelevantForCredit
        item_is_relevant_for_credi TYPE abap_bool,
        "! CreditRelatedPrice
        credit_related_price       TYPE decfloat16,
        "! ShippingPoint
        shipping_point             TYPE c LENGTH 4,
        "! ServiceDocumentType
        service_document_type      TYPE c LENGTH 4,
        "! ServiceDocument
        service_document           TYPE c LENGTH 10,
        "! ServiceDocumentItem
        service_document_item      TYPE c LENGTH 6,
        "! BusinessSolutionOrder
        business_solution_order    TYPE c LENGTH 10,
        "! BusinessSolutionOrderItem
        business_solution_order_it TYPE c LENGTH 6,
        "! HigherLevelItemUsage
        higher_level_item_usage    TYPE c LENGTH 1,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_billing_document_item_type,
      "! <p class="shorttext synchronized">List of BillingDocumentItem_Type</p>
      tyt_billing_document_item_type TYPE STANDARD TABLE OF tys_billing_document_item_type WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">BillingDocumentPartner_Type</p>
      BEGIN OF tys_billing_document_partner_t,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_5,
        "! <em>Key property</em> BillingDocument
        billing_document           TYPE c LENGTH 10,
        "! <em>Key property</em> PartnerFunction
        partner_function           TYPE c LENGTH 2,
        "! Customer
        customer                   TYPE c LENGTH 10,
        "! Supplier
        supplier                   TYPE c LENGTH 10,
        "! Personnel
        personnel                  TYPE c LENGTH 8,
        "! ContactPerson
        contact_person             TYPE c LENGTH 10,
        "! ReferenceBusinessPartner
        reference_business_partner TYPE c LENGTH 10,
        "! BusinessPartnerAddressUUID
        business_partner_address_u TYPE sysuuid_x16,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_billing_document_partner_t,
      "! <p class="shorttext synchronized">List of BillingDocumentPartner_Type</p>
      tyt_billing_document_partner_t TYPE STANDARD TABLE OF tys_billing_document_partner_t WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">BillingDocument_Type</p>
      BEGIN OF tys_billing_document_type,
        "! <em>Value Control Structure</em>
        value_controls             TYPE tys_value_controls_4,
        "! <em>Key property</em> BillingDocument
        billing_document           TYPE c LENGTH 10,
        "! SDDocumentCategory
        sddocument_category        TYPE c LENGTH 4,
        "! BillingDocumentCategory
        billing_document_category  TYPE c LENGTH 1,
        "! BillingDocumentType
        billing_document_type_2    TYPE c LENGTH 4,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! CreationDate
        creation_date              TYPE datn,
        "! CreationTime
        creation_time              TYPE timn,
        "! LastChangeDate
        last_change_date           TYPE datn,
        "! LastChangeDateTime
        last_change_date_time      TYPE timestampl,
        "! LogicalSystem
        logical_system             TYPE c LENGTH 10,
        "! SalesOrganization
        sales_organization         TYPE c LENGTH 4,
        "! DistributionChannel
        distribution_channel       TYPE c LENGTH 2,
        "! Division
        division                   TYPE c LENGTH 2,
        "! BillingDocumentDate
        billing_document_date      TYPE datn,
        "! BillingDocumentIsCancelled
        billing_document_is_cancel TYPE abap_bool,
        "! CancelledBillingDocument
        cancelled_billing_document TYPE c LENGTH 10,
        "! BillingDocCombinationCriteria
        billing_doc_combination_cr TYPE c LENGTH 40,
        "! IsIntrastatReportingRelevant
        is_intrastat_reporting_rel TYPE abap_bool,
        "! IsIntrastatReportingExcluded
        is_intrastat_reporting_exc TYPE abap_bool,
        "! TotalNetAmount
        total_net_amount           TYPE decfloat16,
        "! TransactionCurrency
        transaction_currency       TYPE c LENGTH 3,
        "! StatisticsCurrency
        statistics_currency        TYPE c LENGTH 3,
        "! TotalTaxAmount
        total_tax_amount           TYPE decfloat16,
        "! TotalGrossAmount
        total_gross_amount         TYPE decfloat16,
        "! CustomerPriceGroup
        customer_price_group       TYPE c LENGTH 2,
        "! PriceListType
        price_list_type            TYPE c LENGTH 2,
        "! TaxDepartureCountry
        tax_departure_country      TYPE c LENGTH 3,
        "! VATRegistration
        vatregistration            TYPE c LENGTH 20,
        "! VATRegistrationOrigin
        vatregistration_origin     TYPE c LENGTH 1,
        "! VATRegistrationCountry
        vatregistration_country    TYPE c LENGTH 3,
        "! CustomerTaxClassification1
        customer_tax_classificatio TYPE c LENGTH 1,
        "! CustomerTaxClassification2
        customer_tax_classificat_2 TYPE c LENGTH 1,
        "! CustomerTaxClassification3
        customer_tax_classificat_3 TYPE c LENGTH 1,
        "! CustomerTaxClassification4
        customer_tax_classificat_4 TYPE c LENGTH 1,
        "! CustomerTaxClassification5
        customer_tax_classificat_5 TYPE c LENGTH 1,
        "! CustomerTaxClassification6
        customer_tax_classificat_6 TYPE c LENGTH 1,
        "! CustomerTaxClassification7
        customer_tax_classificat_7 TYPE c LENGTH 1,
        "! CustomerTaxClassification8
        customer_tax_classificat_8 TYPE c LENGTH 1,
        "! CustomerTaxClassification9
        customer_tax_classificat_9 TYPE c LENGTH 1,
        "! IsEUTriangularDeal
        is_eutriangular_deal       TYPE abap_bool,
        "! SDPricingProcedure
        sdpricing_procedure        TYPE c LENGTH 6,
        "! ShippingCondition
        shipping_condition         TYPE c LENGTH 2,
        "! IncotermsVersion
        incoterms_version          TYPE c LENGTH 4,
        "! IncotermsClassification
        incoterms_classification   TYPE c LENGTH 3,
        "! IncotermsTransferLocation
        incoterms_transfer_locatio TYPE c LENGTH 28,
        "! IncotermsLocation1
        incoterms_location_1       TYPE c LENGTH 70,
        "! IncotermsLocation2
        incoterms_location_2       TYPE c LENGTH 70,
        "! PayerParty
        payer_party                TYPE c LENGTH 10,
        "! ContractAccount
        contract_account           TYPE c LENGTH 12,
        "! CustomerPaymentTerms
        customer_payment_terms     TYPE c LENGTH 4,
        "! PaymentMethod
        payment_method             TYPE c LENGTH 1,
        "! PaymentReference
        payment_reference          TYPE c LENGTH 30,
        "! FixedValueDate
        fixed_value_date           TYPE datn,
        "! AdditionalValueDays
        additional_value_days      TYPE c LENGTH 2,
        "! SEPAMandate
        sepamandate                TYPE c LENGTH 35,
        "! CompanyCode
        company_code               TYPE c LENGTH 4,
        "! FiscalYear
        fiscal_year                TYPE c LENGTH 4,
        "! AccountingDocument
        accounting_document        TYPE c LENGTH 10,
        "! CustomerAccountAssignmentGroup
        customer_account_assignmen TYPE c LENGTH 2,
        "! AccountingExchangeRateIsSet
        accounting_exchange_rate_i TYPE abap_bool,
        "! AbsltAccountingExchangeRate
        abslt_accounting_exchange  TYPE p LENGTH 5 DECIMALS 5,
        "! AcctgExchangeRateIsIndrctQtan
        acctg_exchange_rate_is_ind TYPE abap_bool,
        "! ExchangeRateDate
        exchange_rate_date         TYPE datn,
        "! ExchangeRateType
        exchange_rate_type         TYPE c LENGTH 4,
        "! DocumentReferenceID
        document_reference_id      TYPE c LENGTH 16,
        "! AssignmentReference
        assignment_reference       TYPE c LENGTH 18,
        "! ReversalReason
        reversal_reason            TYPE c LENGTH 2,
        "! DunningArea
        dunning_area               TYPE c LENGTH 2,
        "! DunningBlockingReason
        dunning_blocking_reason    TYPE c LENGTH 1,
        "! DunningKey
        dunning_key                TYPE c LENGTH 1,
        "! IsRelevantForAccrual
        is_relevant_for_accrual    TYPE abap_bool,
        "! SoldToParty
        sold_to_party              TYPE c LENGTH 10,
        "! PartnerCompany
        partner_company            TYPE c LENGTH 6,
        "! PurchaseOrderByCustomer
        purchase_order_by_customer TYPE c LENGTH 35,
        "! CustomerGroup
        customer_group             TYPE c LENGTH 2,
        "! Country
        country                    TYPE c LENGTH 3,
        "! CityCode
        city_code                  TYPE c LENGTH 4,
        "! SalesDistrict
        sales_district             TYPE c LENGTH 6,
        "! Region
        region                     TYPE c LENGTH 3,
        "! County
        county                     TYPE c LENGTH 3,
        "! CreditControlArea
        credit_control_area        TYPE c LENGTH 4,
        "! PricingDocument
        pricing_document           TYPE c LENGTH 10,
        "! OverallSDProcessStatus
        overall_sdprocess_status   TYPE c LENGTH 1,
        "! OverallBillingStatus
        overall_billing_status     TYPE c LENGTH 1,
        "! AccountingPostingStatus
        accounting_posting_status  TYPE c LENGTH 1,
        "! AccountingTransferStatus
        accounting_transfer_status TYPE c LENGTH 1,
        "! BillingIssueType
        billing_issue_type         TYPE c LENGTH 1,
        "! InvoiceListStatus
        invoice_list_status        TYPE c LENGTH 1,
        "! OvrlItmGeneralIncompletionSts
        ovrl_itm_general_incomplet TYPE c LENGTH 1,
        "! OverallPricingIncompletionSts
        overall_pricing_incompleti TYPE c LENGTH 1,
        "! InvoiceListType
        invoice_list_type          TYPE c LENGTH 4,
        "! InvoiceListBillingDate
        invoice_list_billing_date  TYPE datn,
        "! SAP__Messages
        sap_messages               TYPE tyt_sap_message,
        "! odata.etag
        etag                       TYPE string,
      END OF tys_billing_document_type,
      "! <p class="shorttext synchronized">List of BillingDocument_Type</p>
      tyt_billing_document_type TYPE STANDARD TABLE OF tys_billing_document_type WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! BillingDocument
        "! <br/> Collection of type 'BillingDocument_Type'
        billing_document           TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'BILLING_DOCUMENT',
        "! BillingDocumentItem
        "! <br/> Collection of type 'BillingDocumentItem_Type'
        billing_document_item      TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'BILLING_DOCUMENT_ITEM',
        "! BillingDocumentItemPartner
        "! <br/> Collection of type 'BillingDocumentItemPartner_Type'
        billing_document_item_part TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'BILLING_DOCUMENT_ITEM_PART',
        "! BillingDocumentPartner
        "! <br/> Collection of type 'BillingDocumentPartner_Type'
        billing_document_partner   TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'BILLING_DOCUMENT_PARTNER',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the bound actions</p>
      BEGIN OF gcs_bound_action,
        "! CreateFromSDDocument
        "! <em>bound against collections of entity type</em> BillingDocument_Type
        "! <br/> See structure type {@link ..tys_parameters_1} for the parameters
        create_from_sddocument TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'CREATE_FROM_SDDOCUMENT',
        "! PostToAccounting
        "! <em>bound against entity type</em> BillingDocument_Type
        post_to_accounting     TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'POST_TO_ACCOUNTING',
      END OF gcs_bound_action.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for complex types</p>
      BEGIN OF gcs_complex_type,
        "! <p class="shorttext synchronized">Internal names for D_BillgDocCrteFrmSDDocRefPP</p>
        "! See also structure type {@link ..tys_d_billg_doc_crte_frm_sddoc}
        BEGIN OF d_billg_doc_crte_frm_sddoc,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF d_billg_doc_crte_frm_sddoc,
        "! <p class="shorttext synchronized">Internal names for D_BillgDocCrteFrmSDDocCtrlPP</p>
        "! See also structure type {@link ..tys_d_billg_doc_crte_frm_sdd_2}
        BEGIN OF d_billg_doc_crte_frm_sdd_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF d_billg_doc_crte_frm_sdd_2,
        "! <p class="shorttext synchronized">Internal names for SAP__Message</p>
        "! See also structure type {@link ..tys_sap_message}
        BEGIN OF sap_message,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF sap_message,
      END OF gcs_complex_type.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for BillingDocumentItemPartner_Type</p>
        "! See also structure type {@link ..tys_billing_document_item_pa_2}
        BEGIN OF billing_document_item_pa_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _BillingDocument
            billing_document_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'BILLING_DOCUMENT_2',
            "! _Item
            item               TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'ITEM',
          END OF navigation,
        END OF billing_document_item_pa_2,
        "! <p class="shorttext synchronized">Internal names for BillingDocumentItem_Type</p>
        "! See also structure type {@link ..tys_billing_document_item_type}
        BEGIN OF billing_document_item_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _BillingDocument
            billing_document_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'BILLING_DOCUMENT_2',
            "! _ItemPartner
            item_partner       TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'ITEM_PARTNER',
          END OF navigation,
        END OF billing_document_item_type,
        "! <p class="shorttext synchronized">Internal names for BillingDocumentPartner_Type</p>
        "! See also structure type {@link ..tys_billing_document_partner_t}
        BEGIN OF billing_document_partner_t,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _BillingDocument
            billing_document_2 TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'BILLING_DOCUMENT_2',
          END OF navigation,
        END OF billing_document_partner_t,
        "! <p class="shorttext synchronized">Internal names for BillingDocument_Type</p>
        "! See also structure type {@link ..tys_billing_document_type}
        BEGIN OF billing_document_type,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! _Item
            item    TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'ITEM',
            "! _Partner
            partner TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'PARTNER',
          END OF navigation,
        END OF billing_document_type,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.

