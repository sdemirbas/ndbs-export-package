projection;
strict ( 2 );

define behavior for ZETR_DDL_C_CUS_MANAGER //alias <alias_name>
{
  use create;
  use update;
  use delete;


  use function GetDefaultsForCreate;
}