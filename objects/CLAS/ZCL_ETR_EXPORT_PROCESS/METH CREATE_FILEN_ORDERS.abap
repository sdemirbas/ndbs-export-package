  METHOD create_filen_orders.

    DATA: lt_invoice_item TYPE TABLE OF zetr_t_r103,
          lt_invoice_head TYPE TABLE OF zetr_t_r102.

    TYPES: tty_vbeln TYPE SORTED TABLE OF i_billingdocument-billingdocument
                      WITH UNIQUE KEY table_line.

    DATA lt_vbeln TYPE tty_vbeln.

    IF it_vbeln IS NOT INITIAL AND iv_document_no IS NOT INITIAL.

      SELECT billingdocument,
             billingdocumentitem
        FROM i_billingdocumentitembasic
     FOR ALL ENTRIES IN @it_vbeln
       WHERE billingdocument = @it_vbeln-billingdocument
        INTO TABLE @DATA(lt_document_item).

      IF lt_document_item IS NOT INITIAL.
        lt_invoice_item = VALUE #( FOR doc IN lt_document_item ( filen = iv_document_no
                                                                 vbeln = doc-billingdocument
                                                                 posnr = doc-billingdocumentitem ) ).
        MODIFY zetr_t_r103 FROM TABLE @lt_invoice_item.

        LOOP AT lt_document_item ASSIGNING FIELD-SYMBOL(<doc>).
          INSERT <doc>-billingdocument INTO TABLE lt_vbeln.
        ENDLOOP.

        lt_invoice_head = VALUE #( FOR v IN lt_vbeln ( filen = iv_document_no
                                                       vbeln = v ) ).

        MODIFY zetr_t_r102 FROM TABLE @lt_invoice_head.
      ENDIF.
    ENDIF.



*    DATA: ls_invoice      TYPE zetr_t_r102,
*          lt_invoice_item TYPE TABLE OF zetr_t_r103.
*
*    IF iv_document_no IS INITIAL OR iv_vbeln IS INITIAL.
*      EXIT.
*    ENDIF.
*
*    ls_invoice = VALUE zetr_t_r102( filen = iv_document_no
*                                    vbeln = iv_vbeln ).
*
*    SELECT billingdocument, billingdocumentitem
*      FROM i_billingdocumentitembasic
*     WHERE billingdocument EQ @iv_vbeln
*      INTO TABLE @DATA(lt_document).
*
*    IF lt_document[] IS NOT INITIAL.
*      LOOP AT lt_document ASSIGNING FIELD-SYMBOL(<fs_document>).
*        APPEND INITIAL LINE TO lt_invoice_item ASSIGNING FIELD-SYMBOL(<fs_invoice_item>).
*        <fs_invoice_item>-filen = iv_document_no.
*        <fs_invoice_item>-vbeln = <fs_document>-billingdocument.
*        <fs_invoice_item>-posnr = <fs_document>-billingdocumentitem.
*      ENDLOOP.
*    ENDIF.
*
*    IF ls_invoice IS NOT INITIAL.
*      MODIFY zetr_t_r102 FROM @ls_invoice.
*    ENDIF.
*
*    IF lt_invoice_item IS NOT INITIAL.
*      MODIFY zetr_t_r103 FROM TABLE @lt_invoice_item.
*    ENDIF.

  ENDMETHOD.