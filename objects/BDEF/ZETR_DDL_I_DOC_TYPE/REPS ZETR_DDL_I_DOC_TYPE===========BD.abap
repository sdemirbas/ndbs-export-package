managed implementation in class zbp_etr_ddl_i_doc_type unique;
strict ( 2 );

define behavior for ZETR_DDL_I_DOC_TYPE //alias <alias_name>
persistent table zetr_t_exp101
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp101
    {
      ExportType            = expty;
      Description           = descr;
      Numke                 = numke;
      Numki                 = numki;
      ScreenLayout          = scrly;
      PrintGroup            = prngr;
      Tdobj                 = tdobj;
      IsDocumentDateChanged = dcidt;
      Accmt                 = accmt;
      Acast                 = acast;
    }

  create;
  update;
  delete;
  field ( readonly ) Language, AccountManagementText, ScreenLayoutText;
}