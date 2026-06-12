  METHOD def_create_from_sddocument.

    DATA:
      lo_action        TYPE REF TO /iwbep/if_v4_pm_action,
      lo_action_import TYPE REF TO /iwbep/if_v4_pm_action_imp,
      lo_parameter     TYPE REF TO /iwbep/if_v4_pm_act_param,
      lo_return        TYPE REF TO /iwbep/if_v4_pm_act_return.


    lo_action = mo_model->create_action( 'CREATE_FROM_SDDOCUMENT' ).
    lo_action->set_edm_name( 'CreateFromSDDocument' ) ##NO_TEXT.


    lo_parameter = lo_action->create_parameter( 'IT' ).
    lo_parameter->set_edm_name( '_it' ) ##NO_TEXT.
    lo_parameter->set_entity_type( 'BILLING_DOCUMENT_TYPE' ).
    lo_parameter->set_is_binding_parameter( ).
    lo_parameter->set_is_collection( ).

    lo_parameter = lo_action->create_parameter( 'CONTROL' ).
    lo_parameter->set_edm_name( '_Control' ) ##NO_TEXT.
    lo_parameter->set_complex_type( 'D_BILLG_DOC_CRTE_FRM_SDD_2' ).

    lo_parameter = lo_action->create_parameter( 'REFERENCE' ).
    lo_parameter->set_edm_name( '_Reference' ) ##NO_TEXT.
    lo_parameter->set_complex_type( 'D_BILLG_DOC_CRTE_FRM_SDDOC' ).
    lo_parameter->set_is_collection( ).

    lo_return = lo_action->create_return( ).
    lo_return->set_entity_type( 'BILLING_DOCUMENT_TYPE' ).
    lo_return->set_is_collection( ).

  ENDMETHOD.