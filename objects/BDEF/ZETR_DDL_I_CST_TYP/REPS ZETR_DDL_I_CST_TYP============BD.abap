managed implementation in class zbp_etr_ddl_i_cst_typ unique;
strict ( 2 );

define behavior for ZETR_DDL_I_CST_TYP //alias <alias_name>
persistent table zetr_t_exp110
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp110
    {
      Ctype       = ctype;
      Description = description;
    }

  create;
  update;
  delete;
}