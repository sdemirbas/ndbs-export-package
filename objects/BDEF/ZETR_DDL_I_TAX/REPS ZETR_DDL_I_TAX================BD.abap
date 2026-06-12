managed implementation in class zbp_etr_ddl_i_tax unique;
strict ( 2 );

define behavior for ZETR_DDL_I_TAX //alias <alias_name>
persistent table zetr_t_exp129
lock master
authorization master ( instance )
//etag master <field_name>
{
  create ( authorization : global );
  update;
  delete;
  field ( readonly : update ) Sirketkodu, Vergikodu, Kosul;

  mapping for zetr_t_exp129
    {
      Kalem      = kalem;
      Kosul      = kosul;
      Sirketkodu = sirketkodu;
      Vergikodu  = vergikodu;
      Yuzde      = yuzde;
    }
}