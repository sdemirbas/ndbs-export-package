managed implementation in class zbp_etr_ddl_i_exp_bank unique;
strict ( 2 );

define behavior for ZETR_DDL_I_EXP_BANK //alias <alias_name>
persistent table zetr_t_exp122
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp122
    {
      Bankcountry = bankcountry;
      Bankname    = bankname;
      iban        = iban;
      Swift       = swift;
      Waers       = Waers;
      bankid      = bankid;
    }

  field ( readonly : update ) Bankcountry, Bankname, Waers;
  create;
  update;
  delete;
}