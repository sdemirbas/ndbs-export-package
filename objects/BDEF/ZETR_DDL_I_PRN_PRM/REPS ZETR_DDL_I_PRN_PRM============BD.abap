managed implementation in class zbp_etr_ddl_i_prn_prm unique;
strict ( 2 );

define behavior for ZETR_DDL_I_PRN_PRM //alias <alias_name>
persistent table zetr_t_exp125
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp125
    {
      ButtonId   = button_id;
      Classname  = classname;
      MethodName = method_name;
      Params     = params;
      ParamsType = params_type;
      Value      = value;
    }

  create;
  update;
  delete;
}