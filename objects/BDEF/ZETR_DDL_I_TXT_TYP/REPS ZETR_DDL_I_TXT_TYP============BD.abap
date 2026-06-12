managed implementation in class zbp_etr_ddl_i_txt_typ unique;
strict ( 2 );

define behavior for ZETR_DDL_I_TXT_TYP //alias <alias_name>
persistent table zetr_t_exp126
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp126
    {
      ObjectCategory = object_category;
      TextKey        = text_key;
    }

  create;
  update;
  delete;

  field ( readonly ) TextObjectTypeName;
}