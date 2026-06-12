managed implementation in class zbp_etr_ddl_i_contract unique;
strict ( 2 );

define behavior for ZETR_DDL_I_CONTRACT //alias <alias_name>
persistent table zetr_t_exp128
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp128
    {
      Customer   = customer;
      Contractno = contractno;
    }

  create;
  update;
  delete;
}