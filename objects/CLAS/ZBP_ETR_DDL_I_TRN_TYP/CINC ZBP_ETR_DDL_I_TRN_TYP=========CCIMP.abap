CLASS lhc_zetr_ddl_i_trn_typ DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zetr_ddl_i_trn_typ RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_trn_typ IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.


CLASS lsc_zetr_ddl_i_trn_typ DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.


CLASS lsc_zetr_ddl_i_trn_typ IMPLEMENTATION.

  METHOD save_modified.
    DATA: lt_main TYPE TABLE OF zetr_t_exp108,
          lt_text TYPE TABLE OF zetr_t_xexp108,
          lt_dele TYPE RANGE OF zetr_e_trnty.

    IF create-zetr_ddl_i_trn_typ IS NOT INITIAL.
      SELECT trnty
        FROM zetr_t_exp108
        FOR ALL ENTRIES IN @create-zetr_ddl_i_trn_typ
        WHERE trnty = @create-zetr_ddl_i_trn_typ-transporttype
        INTO TABLE @DATA(lt_existing_transport_type).
      SORT lt_existing_transport_type BY trnty.
    ENDIF.

    LOOP AT create-zetr_ddl_i_trn_typ INTO DATA(ls_create).
      IF line_exists( lt_existing_transport_type[ trnty = ls_create-transporttype ] ).
        APPEND VALUE #( %msg = new_message( id       = 'ZETR_COMMON'
                                            number   = '200'
                                            severity = if_abap_behv_message=>severity-success
                                            v1       = ls_create-transporttype ) ) TO reported-zetr_ddl_i_trn_typ.
      ELSE.
        APPEND INITIAL LINE TO lt_main ASSIGNING FIELD-SYMBOL(<ls_main>).
        <ls_main>-trnty = ls_create-transporttype.

        APPEND INITIAL LINE TO lt_text ASSIGNING FIELD-SYMBOL(<ls_text>).
        <ls_text>-spras = sy-langu.
        <ls_text>-trnty = ls_create-transporttype.
        <ls_text>-bezei = ls_create-description.
      ENDIF.
    ENDLOOP.

    LOOP AT update-zetr_ddl_i_trn_typ INTO DATA(ls_update).
      APPEND INITIAL LINE TO lt_text ASSIGNING <ls_text>.
      <ls_text>-spras = sy-langu.
      <ls_text>-trnty = ls_create-transporttype.
      <ls_text>-bezei = ls_create-description.
    ENDLOOP.

    LOOP AT delete-zetr_ddl_i_trn_typ INTO DATA(ls_delete).
      APPEND INITIAL LINE TO lt_dele ASSIGNING FIELD-SYMBOL(<ls_dele>).
      <ls_dele>-low = ls_delete-transporttype.
      <ls_dele>-sign = 'I'.
      <ls_dele>-option = 'EQ'.
    ENDLOOP.

    IF lt_dele IS NOT INITIAL.
      DELETE FROM zetr_t_exp108 WHERE trnty IN @lt_dele.
      DELETE FROM zetr_t_xexp108 WHERE trnty IN @lt_dele.
    ENDIF.

    IF lt_main IS NOT INITIAL.
      INSERT zetr_t_exp108 FROM TABLE @lt_main.
    ENDIF.
    IF lt_text IS NOT INITIAL.
      MODIFY zetr_t_xexp108 FROM TABLE @lt_text.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.