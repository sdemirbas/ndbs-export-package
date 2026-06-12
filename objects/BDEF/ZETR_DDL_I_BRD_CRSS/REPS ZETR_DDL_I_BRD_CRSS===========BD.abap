managed implementation in class zbp_etr_ddl_i_brd_crss unique;
strict ( 2 );

define behavior for ZETR_DDL_I_BRD_CRSS //alias <alias_name>
//persistent table zetr_t_exp103
with unmanaged save
lock master
authorization master ( instance )
//etag master <field_name>
{
  create;
  update;
  delete;

  field ( readonly ) Langu;
}