unmanaged implementation in class zbp_etr_ddl_c_exp_invoice unique;
strict;
//strict ( 2 );

define behavior for ZETR_DDL_C_EXP_INVOICE //alias <alias_name>
lock master
authorization master ( instance )

//etag master <field_name>
{

  action Added parameter ZETR_DDL_I_DOCUMENT result [1] $self;
  field ( readonly ) BillingDocument, CompanyCodeName;

}