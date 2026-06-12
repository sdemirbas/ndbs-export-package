managed implementation in class zbp_etr_ddl_i_eori unique;
strict ( 2 );

define behavior for ZETR_DDL_I_EORI //alias <alias_name>
persistent table zetr_t_exp127
lock master
authorization master ( instance )
//etag master <field_name>
{
  mapping for zetr_t_exp127
    {
      Customer = customer;
      Eori     = Eori;
    }

  create;
  update;
  delete;
}