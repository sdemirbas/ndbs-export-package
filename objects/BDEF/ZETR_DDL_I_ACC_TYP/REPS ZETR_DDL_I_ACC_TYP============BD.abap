managed implementation in class zbp_etr_ddl_i_acc_typ unique;
strict ( 2 );

define behavior for ZETR_DDL_I_ACC_TYP
with unmanaged save
lock master
authorization master ( instance )
//etag master <field_name>
{
  create;
  update;
  delete;
  // field ( readonly ) Acast;

  association _Account { create; }
  association _PAChar { create; }
}


define behavior for ZETR_DDL_I_ACC
persistent table zetr_t_exp113
lock dependent by _AccountType
authorization master ( instance )
{

  mapping for zetr_t_exp113
    {
      Acast   = acast;
      Intac   = intac;
      Sgcac   = sgcac;
    }

  update;
  delete;
  field ( readonly ) Acast, Intac;

  association _AccountType;
}


define behavior for ZETR_DDL_I_PA_CHR
persistent table zetr_t_exp114
lock dependent by _AccountType
authorization master ( instance )
{

  mapping for zetr_t_exp114
    {
      Acast   = acast;
      Pafnm   = pafnm;
    }

  update;
  delete;
  field ( readonly ) Acast;

  association _AccountType;
}