unmanaged implementation in class zbp_etr_ddl_i_exp_inv_head_rpt unique;
strict;

define behavior for ZETR_DDL_I_EXP_INV_HEAD_RPT //alias <alias_name>
//persistent table <???>
lock master
authorization master ( instance )
//etag master <field_name>
{

  action Added parameter ZETR_DDL_I_DOCUMENT result [1] $self;
  field ( readonly ) BillingDocument, CompanyCodeName;
}