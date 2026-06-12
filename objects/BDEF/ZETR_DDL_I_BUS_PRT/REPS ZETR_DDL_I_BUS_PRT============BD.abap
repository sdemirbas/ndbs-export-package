managed implementation in class zbp_etr_ddl_i_bus_prt unique;
strict ( 2 );

define behavior for ZETR_DDL_I_BUS_PRT //alias <alias_name>
persistent table zetr_t_exp115
lock master
authorization master ( instance )
//etag master <field_name>
{


  mapping for zetr_t_exp115
    {
      Prtty   = prtty;
      Partner = Partner;
    }

  create;
  update;
  delete;
  field ( readonly ) FirstName, LastName, FullName;
}