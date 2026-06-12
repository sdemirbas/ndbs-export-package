managed implementation in class zbp_etr_ddl_i_cuscd unique;
strict ( 2 );

define behavior for ZETR_DDL_I_CUSCD //alias <alias_name>
//persistent table <???>
with unmanaged save
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp112
    {
      Land1 = land1;
      Cuscd = cuscd;
    }
  create;
  update;
  delete;
}