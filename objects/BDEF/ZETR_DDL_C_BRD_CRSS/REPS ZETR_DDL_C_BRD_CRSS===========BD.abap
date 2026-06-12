projection;
strict ( 2 );

define behavior for ZETR_DDL_C_BRD_CRSS //alias <alias_name>
{

  mapping for zetr_t_exp103
    {
      Langu       = langu;
      Snrkp       = snrkp;
      Description = description;
    }
  use create;
  use update;
  use delete;
  field ( readonly ) Langu;
}