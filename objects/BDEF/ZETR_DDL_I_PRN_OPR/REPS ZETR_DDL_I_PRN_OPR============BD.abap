managed implementation in class zbp_etr_ddl_i_prn_opr unique;
strict ( 2 );

define behavior for ZETR_DDL_I_PRN_OPR //alias <alias_name>
persistent table zetr_t_exp124
lock master
authorization master ( instance )
//etag master <field_name>
{

  mapping for zetr_t_exp124
    {
      ButtonIcon     = button_icon;
      ButtonId       = button_id;
      ButtonName     = button_name;
      ButtonNameEn   = button_name_en;
      CommScenario   = comm_scenario;
      CommSystemId   = comm_system_id;
      FormName       = form_name;
      FormStrName    = form_str_name;
      FormTrnsName   = form_trns_name;
      FormTrnsSource = form_trns_source;
      IsForm         = is_form;
      ServiceId      = service_id;
    }

  create;
  update;
  delete;
}