CLASS lhc_zetr_ddl_i_cus_manager DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zetr_ddl_i_cus_manager RESULT result.

    METHODS getdefaultsforcreate FOR READ
       keys FOR FUNCTION cusmanager~getdefaultsforcreate RESULT result.

ENDCLASS.

CLASS lhc_zetr_ddl_i_cus_manager IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD getdefaultsforcreate.

    result = VALUE #(

      (
          %cid  = keys[ 1 ]-%cid
          %param-spras = sy-langu

      )

  ).
  ENDMETHOD.

ENDCLASS.