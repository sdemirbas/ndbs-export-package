CLASS zetr_exp_journal_entry DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      create_journal_entry IMPORTING it_data     TYPE zjournal_entry_create_requ_tab
                           EXPORTING et_response TYPE zjournal_entry_create_conf_tab

                           RAISING   cx_soap_destination_error
                                     cx_ai_system_fault.