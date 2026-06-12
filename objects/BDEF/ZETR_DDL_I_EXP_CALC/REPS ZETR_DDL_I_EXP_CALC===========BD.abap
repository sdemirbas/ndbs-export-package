managed implementation in class zbp_etr_ddl_i_exp_calc unique;
strict ( 2 );

define behavior for ZETR_DDL_I_EXP_CALC //alias <alias_name>
persistent table zetr_t_exp119
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp119
    {
      Bukrs   = bukrs;
      Ctype   = ctype;
      Calty   = calty;
    }
  create;
  update;
  delete;
}