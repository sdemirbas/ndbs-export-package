managed implementation in class zbp_etr_ddl_c_costing unique;
strict ( 1 );

define behavior for ZETR_DDL_C_Costing //alias <alias_name>
with unmanaged save
lock master
authorization master ( instance )
//etag master <field_name>
{

  field ( readonly ) Dummy;

  static action onSave deep parameter Zetr_ABS_ROOT_PARAM result [1] $self;
}