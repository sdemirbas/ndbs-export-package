CLASS lhc_zetr_ddl_i_cuscd DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_cuscd RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_cuscd IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zetr_ddl_i_cuscd DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zetr_ddl_i_cuscd IMPLEMENTATION.

  METHOD save_modified.
    DATA: lt_main TYPE TABLE OF zetr_t_exp112,
          lt_text TYPE TABLE OF zetr_t_xexp112,
          lt_dele TYPE RANGE OF zetr_e_cuscd.

    IF create-zetr_ddl_i_cuscd IS NOT INITIAL.
      SELECT cuscd
        FROM zetr_t_exp112
        FOR ALL ENTRIES IN @create-zetr_ddl_i_cuscd
        WHERE cuscd = @create-zetr_ddl_i_cuscd-cuscd AND
              land1 = @create-zetr_ddl_i_cuscd-land1
        INTO TABLE @DATA(lt_existing).
      SORT lt_existing BY cuscd.
    ENDIF.

    LOOP AT create-zetr_ddl_i_cuscd INTO DATA(ls_create).
      IF line_exists( lt_existing[ cuscd = ls_create-cuscd ] ).
        APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                            number   = '200'
                                            severity = if_abap_behv_message=>severity-success
                                            v1       = ls_create-cuscd ) ) TO reported-zetr_ddl_i_cuscd.
      ELSE.
        APPEND INITIAL LINE TO lt_main ASSIGNING FIELD-SYMBOL(<ls_main>).
        MOVE-CORRESPONDING ls_create TO <ls_main>.


        APPEND INITIAL LINE TO lt_text ASSIGNING FIELD-SYMBOL(<ls_text>).
        <ls_text>-spras = sy-langu.
        <ls_text>-cuscd = ls_create-cuscd.
        <ls_text>-land1 = ls_create-land1.
        <ls_text>-bezei = ls_create-description.
      ENDIF.
    ENDLOOP.

    LOOP AT update-zetr_ddl_i_cuscd INTO DATA(ls_update).
      APPEND INITIAL LINE TO lt_text ASSIGNING <ls_text>.
      <ls_text>-spras = sy-langu.
      <ls_text>-cuscd = ls_create-cuscd.
      <ls_text>-land1 = ls_create-land1.
      <ls_text>-bezei = ls_create-description.
    ENDLOOP.

    LOOP AT delete-zetr_ddl_i_cuscd INTO DATA(ls_delete).
      APPEND INITIAL LINE TO lt_dele ASSIGNING FIELD-SYMBOL(<ls_dele>).
      <ls_dele>-low = ls_delete-land1.
      <ls_dele>-sign = 'I'.
      <ls_dele>-option = 'EQ'.
    ENDLOOP.

    IF lt_dele IS NOT INITIAL.
      DELETE FROM zetr_t_exp112 WHERE land1 IN @lt_dele.
      DELETE FROM zetr_t_exp112 WHERE cuscd IN @lt_dele.
    ENDIF.

    IF lt_main IS NOT INITIAL.
      INSERT zetr_t_exp112 FROM TABLE @lt_main.
    ENDIF.
    IF lt_text IS NOT INITIAL.
      MODIFY zetr_t_xexp112 FROM TABLE @lt_text.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.