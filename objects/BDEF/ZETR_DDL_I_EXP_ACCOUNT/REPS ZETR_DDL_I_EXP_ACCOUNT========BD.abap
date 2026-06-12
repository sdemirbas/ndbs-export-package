managed implementation in class zbp_etr_ddl_i_exp_account unique;
strict ( 2 );

define behavior for ZETR_DDL_I_EXP_ACCOUNT //alias <alias_name>
persistent table zetr_t_exp120
lock master
authorization master ( instance )
//etag master <field_name>
{

  field ( readonly : update ) Bukrs, ctype;

  mapping for zetr_t_exp120
    {
      Bukrs   = bukrs;
      Ctype   = ctype;
      Kostl   = kostl;
      Saknr   = saknr;
    }
  create;
  update;
  delete;
}