managed implementation in class zbp_etr_ddl_i_screen_layout unique;
strict ( 2 );

define behavior for ZETR_DDL_I_SCREEN_LAYOUT //alias <alias_name>
persistent table zetr_t_exp102
lock master
authorization master ( instance )
//etag master <field_name>
{
  mapping for zetr_t_exp102
    {
      Langu       = langu;
      Scrly       = scrly;
      Description = description;
    }

  create;
  update;
  delete;
  association _ScreenParameter { create; }
}

define behavior for ZETR_DDL_I_SCREEN_PARAMETER //alias <alias_name>
persistent table zetr_t_t103
lock dependent by _ScreenLayout
authorization dependent by _ScreenLayout
//etag master <field_name>
{

  mapping for zetr_t_t103
    {
      Langu   = langu;
      Scrly   = scrly;
      Flloc   = flloc;
      Fname   = fname;
      Flatt   = flatt;
      Defvl   = defvl;
    }

  update;
  delete;
  field ( readonly ) Langu, Scrly, FieldLocationText, FieldAttributesText;
  association _ScreenLayout;
}