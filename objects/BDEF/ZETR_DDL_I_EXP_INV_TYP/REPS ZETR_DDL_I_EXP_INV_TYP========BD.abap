managed implementation in class zbp_etr_ddl_i_exp_inv_typ unique;
strict ( 2 );

define behavior for ZETR_DDL_I_EXP_INV_TYP //alias <alias_name>
persistent table zetr_t_exp121
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp121
    {
      DocumentType = fkart;
    }

  create;
  update;
  delete;
}