INTERFACE zetr_if_virtual
  PUBLIC .

  METHODS: set_data
    IMPORTING it_original_data           TYPE STANDARD TABLE
              it_requested_calc_elements TYPE SORTED TABLE
    CHANGING  ct_calculated_data         TYPE STANDARD TABLE.

  INTERFACES if_badi_interface .
ENDINTERFACE.