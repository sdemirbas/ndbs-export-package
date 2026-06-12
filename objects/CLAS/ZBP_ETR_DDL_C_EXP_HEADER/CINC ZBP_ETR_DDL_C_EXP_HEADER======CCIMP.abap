CLASS lhc_zetr_ddl_c_bil_doc DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS releasetoaccountingbildoc FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_c_bil_doc~releasetoaccountingbildoc.

ENDCLASS.

CLASS lhc_zetr_ddl_c_bil_doc IMPLEMENTATION.

  METHOD releasetoaccountingbildoc.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zetr_ddl_c_exp_header DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS releasetoaccounting FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_c_exp_header~releasetoaccounting.
    METHODS closedexport FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_c_exp_header~closedexport.
    METHODS searchbankaccount FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_c_exp_header~searchbankaccount.



ENDCLASS.

CLASS lhc_zetr_ddl_c_exp_header IMPLEMENTATION.

  METHOD releasetoaccounting.
    DATA: lt_export TYPE TABLE OF zetr_t_r101.

    DATA(ls_keys) = VALUE #( keys[ 1 ]  OPTIONAL ).

    IF ls_keys IS NOT INITIAL.
      SELECT SINGLE * FROM zetr_t_r101 WHERE filen = @ls_keys-filen INTO @DATA(ls_r101) .
    ENDIF.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).
      APPEND INITIAL LINE TO lt_export ASSIGNING FIELD-SYMBOL(<fs_export>).
      MOVE-CORRESPONDING ls_r101 TO <fs_export>.
      <fs_export>-filen         = <fs_key>-filen.
      <fs_export>-isaccounting  =  SWITCH #( <fs_export>-isaccounting WHEN abap_true  THEN abap_false
                                                                      WHEN abap_false THEN abap_true ).
    ENDLOOP.
    MODIFY zetr_t_r101 FROM TABLE @lt_export.

    APPEND VALUE #( %msg = new_message( id       = 'ZETR_EXP'
                                        number   = '004'
                                        severity = if_abap_behv_message=>severity-success ) ) TO reported-zetr_ddl_c_exp_header.

  ENDMETHOD.

  METHOD closedexport.
    DATA: lt_export TYPE TABLE OF zetr_t_r101.

    DATA(ls_keys) = VALUE #( keys[ 1 ]  OPTIONAL ).

    IF ls_keys IS NOT INITIAL.
      SELECT SINGLE * FROM zetr_t_r101 WHERE filen = @ls_keys-filen INTO @DATA(ls_r101) .
    ENDIF.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).
      APPEND INITIAL LINE TO lt_export ASSIGNING FIELD-SYMBOL(<fs_export>).
      MOVE-CORRESPONDING ls_r101 TO <fs_export>.
      <fs_export>-filen         = <fs_key>-filen.
      <fs_export>-clsed  =  SWITCH #( <fs_export>-clsed WHEN abap_true  THEN abap_false
                                                        WHEN abap_false THEN abap_true ).
    ENDLOOP.
    MODIFY zetr_t_r101 FROM TABLE @lt_export.

    APPEND VALUE #( %msg = new_message( id       = 'ZETR_EXP'
                                        number   = '006'
                                        severity = if_abap_behv_message=>severity-success ) ) TO reported-zetr_ddl_c_exp_header.
  ENDMETHOD.

  METHOD searchbankaccount.



  ENDMETHOD.
ENDCLASS.

CLASS lhc_zetr_ddl_c_exp_invh DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS navigatednewpage FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_c_exp_invh~navigatednewpage.


ENDCLASS.

CLASS lhc_zetr_ddl_c_exp_invh IMPLEMENTATION.

  METHOD navigatednewpage.
  ENDMETHOD.

ENDCLASS.