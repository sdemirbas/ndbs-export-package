managed implementation in class zbp_etr_ddl_i_trn_typ unique;
strict ( 2 );

define behavior for ZETR_DDL_I_TRN_TYP //alias <alias_name>
//persistent table zetr_t_exp108
with unmanaged save
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp108
    {
      TransportType = trnty;
    }
  create;
  update;
  delete;
}