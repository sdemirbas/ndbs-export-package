  METHOD if_sadl_exit_calc_element_read~calculate.

    CHECK NOT it_original_data IS INITIAL.

    DATA(lo_instance) = zetr_if_exp_virtual=>get_instance(  ).

    CALL BADI lo_instance->set_data
      EXPORTING
        it_original_data           = it_original_data
        it_requested_calc_elements = it_requested_calc_elements
      CHANGING
        ct_calculated_data         = ct_calculated_data.

  ENDMETHOD.