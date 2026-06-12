managed implementation in class zbp_etr_ddl_i_cnt_typ unique;
strict ( 2 );

define behavior for ZETR_DDL_I_CNT_TYP //alias <alias_name>
with unmanaged save
lock master
authorization master ( instance )
{

  mapping for zetr_t_exp117
    {
      Conty = conty;
    }
  create;
  update;
  delete;
}