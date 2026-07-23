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
    METHODS savefobdistribution FOR MODIFY
      IMPORTING keys FOR ACTION zetr_ddl_c_exp_header~savefobdistribution.




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
*  METHOD savefobdistribution.
*
*    TYPES:
*      BEGIN OF ty_fob_line,
*        billing_document TYPE zetr_e_vbeln,
*        fob_amount       TYPE string,
*      END OF ty_fob_line,
*      tt_fob_line TYPE STANDARD TABLE OF ty_fob_line WITH EMPTY KEY.
*
*    DATA: lt_fob_json TYPE tt_fob_line,
*          lv_json     TYPE string,
*          lv_total    TYPE p DECIMALS 3.
*
*
*    READ TABLE keys INTO DATA(ls_key) INDEX 1.
*    CHECK ls_key IS NOT INITIAL.
*
*    lv_json = ls_key-%param-fobdata.
*
*    " ── JSON → internal table ────────────────────────────────────
*    /ui2/cl_json=>deserialize(
*      EXPORTING
*        json        = lv_json
*        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
*      CHANGING
*        data        = lt_fob_json ).
*
*    " ── Validasyon ───────────────────────────────────────────────
*    IF lt_fob_json IS INITIAL.
*      APPEND VALUE #( %tky = ls_key-%tky
*                      %msg = new_message( id       = 'ZETR_EXP'
*                                          number   = '010'
*                                          severity = if_abap_behv_message=>severity-error ) )
*             TO reported-zetr_ddl_c_exp_header.
*      APPEND VALUE #( %tky = ls_key-%tky ) TO failed-zetr_ddl_c_exp_header.
*      RETURN.
*    ENDIF.
*
*    " ── zetr_t_r102: FOB güncelle / ekle + toplam hesapla ────────
*    LOOP AT lt_fob_json ASSIGNING FIELD-SYMBOL(<fs_fob>).
*
*      DATA(lv_fob_val) = CONV zetr_t_r102-fob( <fs_fob>-fob_amount ).
*
*      UPDATE zetr_t_r102
*         SET fob = @lv_fob_val
*       WHERE filen = @ls_key-filen
*         AND vbeln = @<fs_fob>-billing_document.
*
*      " Toplama ekle
*      lv_total = lv_total + lv_fob_val.
*
*    ENDLOOP.
*
*    UPDATE zetr_t_r101
*       SET shpno = @( CONV zetr_e_shpno( lv_total ) )
*     WHERE filen = @ls_key-filen.
*
*
*    APPEND VALUE #( %tky = ls_key-%tky
*                    %msg = new_message( id       = 'ZETR_EXP'
*                                        number   = '011'
*                                        severity = if_abap_behv_message=>severity-success ) )
*           TO reported-zetr_ddl_c_exp_header.
*
*  ENDMETHOD.


  METHOD savefobdistribution.

    TYPES:
      BEGIN OF ty_fob_line,
        billing_document TYPE string,
        fob_amount       TYPE string,
      END OF ty_fob_line,

      tt_fob_line TYPE STANDARD TABLE OF ty_fob_line
        WITH EMPTY KEY.

    DATA:
      lt_fob_json TYPE tt_fob_line,
      lv_json     TYPE string,
      lv_total    TYPE decfloat34,
      lv_vbeln    TYPE zetr_t_r102-vbeln,
      lv_fob_val  TYPE zetr_t_r102-fob.

    READ TABLE keys
      INTO DATA(ls_key)
      INDEX 1.

    IF sy-subrc <> 0 OR ls_key IS INITIAL.
      RETURN.
    ENDIF.

    lv_json = ls_key-%param-fobdata.

    " JSON -> internal table
    /ui2/cl_json=>deserialize(
      EXPORTING
        json        = lv_json
        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
      CHANGING
        data        = lt_fob_json
    ).

    " JSON boşsa hata
    IF lt_fob_json IS INITIAL.

      APPEND VALUE #(
        %tky = ls_key-%tky
        %msg = new_message(
          id       = 'ZETR_EXP'
          number   = '010'
          severity = if_abap_behv_message=>severity-error
        )
      ) TO reported-zetr_ddl_c_exp_header.

      APPEND VALUE #(
        %tky = ls_key-%tky
      ) TO failed-zetr_ddl_c_exp_header.

      RETURN.

    ENDIF.

    CLEAR lv_total.

    LOOP AT lt_fob_json ASSIGNING FIELD-SYMBOL(<fs_fob>).

      CLEAR:
        lv_vbeln,
        lv_fob_val.

      " Fatura numarasını SAP internal formata çevir.
      " 90000091 -> 0090000091
      lv_vbeln = |{
        <fs_fob>-billing_document
        ALPHA = IN
      }|.

      " FOB değerini decimal alana çevir
      TRY.

          lv_fob_val = CONV #(
            <fs_fob>-fob_amount
          ).

        CATCH cx_sy_conversion_no_number
              cx_sy_conversion_overflow.

          APPEND VALUE #(
            %tky = ls_key-%tky
            %msg = new_message_with_text(
              severity = if_abap_behv_message=>severity-error
              text     = |{
                <fs_fob>-billing_document
              } faturası için FOB değeri geçersiz.|
            )
          ) TO reported-zetr_ddl_c_exp_header.

          APPEND VALUE #(
            %tky = ls_key-%tky
          ) TO failed-zetr_ddl_c_exp_header.

          RETURN.

      ENDTRY.

      " Negatif değer kontrolü
      IF lv_fob_val < 0.

        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = |FOB değeri negatif olamaz: { lv_vbeln }|
          )
        ) TO reported-zetr_ddl_c_exp_header.

        APPEND VALUE #(
          %tky = ls_key-%tky
        ) TO failed-zetr_ddl_c_exp_header.

        RETURN.

      ENDIF.

      " Yalnızca ALPHA dönüşümü uygulanmış VBELN ile güncelle
      UPDATE zetr_t_r102
         SET fob = @lv_fob_val
       WHERE filen = @ls_key-filen
         AND vbeln = @lv_vbeln.

      " Kayıt yoksa sessizce devam etme
      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = |{
              lv_vbeln
            } numaralı fatura ZETR_T_R102 tablosunda bulunamadı.|
          )
        ) TO reported-zetr_ddl_c_exp_header.

        APPEND VALUE #(
          %tky = ls_key-%tky
        ) TO failed-zetr_ddl_c_exp_header.

        RETURN.

      ENDIF.

      lv_total = lv_total + lv_fob_val.

    ENDLOOP.


    DATA lv_shpno TYPE zetr_e_shpno.

    lv_shpno = CONV zetr_e_shpno( lv_total ).

    UPDATE zetr_t_r101
       SET shpno = @lv_shpno
     WHERE filen = @ls_key-filen.

    IF sy-subrc <> 0.

      APPEND VALUE #(
        %tky = ls_key-%tky
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = |{
            ls_key-filen
          } numaralı ihracat dosyası güncellenemedi.|
        )
      ) TO reported-zetr_ddl_c_exp_header.

      APPEND VALUE #(
        %tky = ls_key-%tky
      ) TO failed-zetr_ddl_c_exp_header.

      RETURN.

    ENDIF.

    APPEND VALUE #(
      %tky = ls_key-%tky
      %msg = new_message(
        id       = 'ZETR_EXP'
        number   = '011'
        severity = if_abap_behv_message=>severity-success
      )
    ) TO reported-zetr_ddl_c_exp_header.

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