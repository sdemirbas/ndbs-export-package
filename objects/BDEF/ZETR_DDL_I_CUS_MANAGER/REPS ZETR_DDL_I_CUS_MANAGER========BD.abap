managed implementation in class zbp_etr_ddl_i_cus_manager unique;
strict ( 2 );

define behavior for ZETR_DDL_I_CUS_MANAGER alias CusManager
persistent table zetr_t_exp131
lock master
authorization master ( instance )
{
  // create;
  update;
  delete;

  create { default function GetDefaultsForCreate; }

  //determination SetLanguage on modify { create; }

  mapping for zetr_t_exp131
    {
      Cusmn       = cusmn;
      Description = description;
      Spras       = spras;
    }
}