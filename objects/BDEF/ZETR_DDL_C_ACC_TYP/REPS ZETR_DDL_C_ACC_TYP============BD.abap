projection;
strict ( 2 );

define behavior for ZETR_DDL_C_ACC_TYP //alias <alias_name>
{
  use create;
  use update;
  use delete;


  use association _Account { create; }
  use association _PAChar { create; }
}


define behavior for ZETR_DDL_C_ACC//alias <alias_name>
{
  use update;
  use delete;

  use association _AccountType;
}


define behavior for ZETR_DDL_C_PA_CHR//alias <alias_name>
{
  use update;
  use delete;

  use association _AccountType;
}