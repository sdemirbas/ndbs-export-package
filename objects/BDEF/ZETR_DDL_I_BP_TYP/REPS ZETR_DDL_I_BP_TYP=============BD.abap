managed implementation in class zbp_etr_ddl_i_bp_typ unique;
strict ( 2 );

define behavior for ZETR_DDL_I_BP_TYP
persistent table zetr_t_exp116
lock master
authorization master ( instance )
{

  mapping for zetr_t_exp116
    {
      Prtty   = prtty;
      Relpr   = relpr;
    }

  create;
  update;
  delete;
}