managed implementation in class zbp_etr_ddl_i_vorgang unique;
strict ( 2 );

define behavior for ZETR_DDL_I_VORGANG //alias <alias_name>
persistent table zetr_t_exp118
lock master
authorization master ( instance )
//etag master <field_name>
{
   mapping for zetr_t_exp118
    {
      Vorgang = vorgang;
      Blart   = blart;
    }

  field ( readonly ) VorgangText;
  create;
  update;
  delete;
}