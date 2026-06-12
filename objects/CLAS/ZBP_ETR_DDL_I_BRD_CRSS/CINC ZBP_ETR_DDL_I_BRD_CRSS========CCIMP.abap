CLASS lsc_zetr_ddl_i_brd_crss DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zetr_ddl_i_brd_crss IMPLEMENTATION.

  METHOD save_modified.
    DATA: lt_main TYPE TABLE OF zetr_t_exp103,
          lt_dele TYPE RANGE OF zetr_e_snrkp.

    IF create-zetr_ddl_i_brd_crss IS NOT INITIAL.
      SELECT snrkp
        FROM zetr_t_exp103
        FOR ALL ENTRIES IN @create-zetr_ddl_i_brd_crss
        WHERE snrkp = @create-zetr_ddl_i_brd_crss-snrkp
        INTO TABLE @DATA(lt_existing).
      SORT lt_existing BY snrkp.
    ENDIF.

    LOOP AT create-zetr_ddl_i_brd_crss INTO DATA(ls_create).
      IF line_exists( lt_existing[ snrkp = ls_create-snrkp ] ).
        APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                            number   = '200'
                                            severity = if_abap_behv_message=>severity-success
                                            v1       = ls_create-snrkp ) ) TO reported-zetr_ddl_i_brd_crss.
      ELSE.
        APPEND INITIAL LINE TO lt_main ASSIGNING FIELD-SYMBOL(<ls_main>).
        <ls_main>-snrkp       = ls_create-snrkp.
        <ls_main>-langu       = sy-langu.
        <ls_main>-description = ls_create-description.
      ENDIF.
    ENDLOOP.

    LOOP AT update-zetr_ddl_i_brd_crss INTO DATA(ls_update).
      APPEND INITIAL LINE TO lt_main ASSIGNING <ls_main>.
      <ls_main>-snrkp       = ls_update-snrkp.
      <ls_main>-langu       = sy-langu.
      <ls_main>-description = ls_update-description.
    ENDLOOP.

    LOOP AT delete-zetr_ddl_i_brd_crss INTO DATA(ls_delete).
      APPEND INITIAL LINE TO lt_dele ASSIGNING FIELD-SYMBOL(<ls_dele>).
      <ls_dele>-low    = ls_delete-snrkp.
      <ls_dele>-sign   = 'I'.
      <ls_dele>-option = 'EQ'.
    ENDLOOP.

    IF lt_dele IS NOT INITIAL.
      DELETE FROM zetr_t_exp103 WHERE snrkp IN @lt_dele.
    ENDIF.

    IF create-zetr_ddl_i_brd_crss IS NOT INITIAL.
      INSERT zetr_t_exp103 FROM TABLE @lt_main.
    ENDIF.

    IF update-zetr_ddl_i_brd_crss IS NOT INITIAL .
      MODIFY zetr_t_exp103 FROM TABLE @lt_main.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zetr_ddl_i_brd_crss DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_brd_crss RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_brd_crss IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.