managed implementation in class zbp_etr_ddl_i_pymty_typ unique;
strict ( 2 );

define behavior for ZETR_DDL_I_PYMTY_TYP //alias <alias_name>
//persistent table zetr_t_exp107
with unmanaged save
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp107
    {
      PaymentType = pymty;
    }
  create;
  update;
  delete;
}