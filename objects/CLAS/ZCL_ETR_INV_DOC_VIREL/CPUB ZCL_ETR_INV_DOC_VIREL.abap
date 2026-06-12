CLASS zcl_etr_inv_doc_virel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read .

    CLASS-METHODS get_ui_url
      RETURNING
        VALUE(rv_url) TYPE string.