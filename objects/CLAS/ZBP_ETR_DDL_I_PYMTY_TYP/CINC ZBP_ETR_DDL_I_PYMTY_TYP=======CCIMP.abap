CLASS lhc_zetr_ddl_i_pymty_typ DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_pymty_typ RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_pymty_typ IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.



CLASS lsc_zetr_ddl_i_pymty_typ DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.


CLASS lsc_zetr_ddl_i_pymty_typ IMPLEMENTATION.

  METHOD save_modified.
    DATA: lt_main TYPE TABLE OF zetr_t_exp107,
          lt_text TYPE TABLE OF zetr_t_xexp107,
          lt_dele TYPE RANGE OF zetr_e_pymty.

    IF create-zetr_ddl_i_pymty_typ IS NOT INITIAL.
      SELECT pymty
        FROM zetr_t_exp107
        FOR ALL ENTRIES IN @create-zetr_ddl_i_pymty_typ
        WHERE pymty = @create-zetr_ddl_i_pymty_typ-paymenttype
        INTO TABLE @DATA(lt_existing).
      SORT lt_existing BY pymty.
    ENDIF.

    LOOP AT create-zetr_ddl_i_pymty_typ INTO DATA(ls_create).
      IF line_exists( lt_existing[ pymty = ls_create-paymenttype ] ).
        APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                            number   = '200'
                                            severity = if_abap_behv_message=>severity-success
                                            v1       = ls_create-paymenttype ) ) TO reported-zetr_ddl_i_pymty_typ.
      ELSE.
        APPEND INITIAL LINE TO lt_main ASSIGNING FIELD-SYMBOL(<ls_main>).
        <ls_main>-pymty = ls_create-paymenttype.

        APPEND INITIAL LINE TO lt_text ASSIGNING FIELD-SYMBOL(<ls_text>).
        <ls_text>-spras = sy-langu.
        <ls_text>-pymty = ls_create-paymenttype.
        <ls_text>-bezei = ls_create-description.
      ENDIF.
    ENDLOOP.

    LOOP AT update-zetr_ddl_i_pymty_typ INTO DATA(ls_update).
      APPEND INITIAL LINE TO lt_text ASSIGNING <ls_text>.
      <ls_text>-spras = sy-langu.
      <ls_text>-pymty = ls_create-paymenttype.
      <ls_text>-bezei = ls_create-description.
    ENDLOOP.

    LOOP AT delete-zetr_ddl_i_pymty_typ INTO DATA(ls_delete).
      APPEND INITIAL LINE TO lt_dele ASSIGNING FIELD-SYMBOL(<ls_dele>).
      <ls_dele>-low = ls_delete-paymenttype.
      <ls_dele>-sign = 'I'.
      <ls_dele>-option = 'EQ'.
    ENDLOOP.

    IF lt_dele IS NOT INITIAL.
      DELETE FROM zetr_t_exp107 WHERE pymty IN @lt_dele.
      DELETE FROM zetr_t_xexp107 WHERE pymty IN @lt_dele.
    ENDIF.

    IF lt_main IS NOT INITIAL.
      INSERT zetr_t_exp107 FROM TABLE @lt_main.
    ENDIF.
    IF lt_text IS NOT INITIAL.
      MODIFY zetr_t_xexp107 FROM TABLE @lt_text.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.