projection;
strict ( 2 );

define behavior for ZETR_DDL_C_SCREEN_LAYOUT //alias <alias_name>
{
  use create;
  use update;
  use delete;

  use association _ScreenParameter { create; }
}

define behavior for ZETR_DDL_C_SCREEN_PARAMETER //alias <alias_name>
{
  use update;
  use delete;

  use association _ScreenLayout;
}