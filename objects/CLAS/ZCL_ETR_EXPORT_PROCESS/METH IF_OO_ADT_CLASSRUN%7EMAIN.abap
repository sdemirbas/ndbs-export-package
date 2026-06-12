  METHOD if_oo_adt_classrun~main.
    TRY.
        create_reference_document( it_reference_document = VALUE #( ( ) )
                                   iv_filen = '123123123' ).


      CATCH cx_soap_destination_error cx_ai_system_fault.
        "handle exception
    ENDTRY.

  ENDMETHOD.