managed implementation in class zbp_etr_ddl_i_exp_head unique;
strict;

define behavior for ZETR_DDL_I_EXP_HEAD
lock master
early numbering
with unmanaged save
authorization master ( instance )
{
  create;
  update;
  delete;
  field ( readonly ) Filen, Pymty, Clsed, StatusClosed;
  field ( mandatory : create ) Kunrg, Bldat, Bukrs, Expty;


  validation validateGeneral on save { create; update; }

  action releaseToAccounting;

  association _InvoiceHeader { create; }
  association _InvoiceItem { create; }
  association _Texts { create; }
  association _BillingDocument { create; }
  association _Costing { create; }


}


define behavior for ZETR_DDL_I_EXPORT_INVH
//persistent table zetr_t_r102
late numbering
with unmanaged save
lock dependent by _ExportFile
authorization dependent by _ExportFile
{
  action getpdf parameter zetr_ddl_i_button result [1] ZETR_DDL_I_CONTENT;
  action navigatedNewPage result [1] $self;
  action deletedinvoice result [1] $self;

  mapping for zetr_t_r102
    {
      FileExportNumber = Filen;
      BillingDocument  = Vbeln;
    }

  delete;

  field ( readonly ) FileExportNumber, BillingDocument;
  association _ExportFile;


}

define behavior for ZETR_DDL_I_EXPORT_INVI
//persistent table zetr_t_r103
late numbering
with unmanaged save
lock dependent by _ExportFile
authorization dependent by _ExportFile
{


  mapping for zetr_t_r103
    {
      filen               = Filen;
      vbeln               = Vbeln;
      BillingDocumentItem = Posnr;
    }

  delete;


  field ( readonly ) vbeln, filen;
  association _ExportFile;
}

define behavior for ZETR_DDL_I_EXP_TXT
//persistent table zetr_t_exp123
with unmanaged save
lock dependent by _ExportFile
authorization dependent by _ExportFile
{


  mapping for zetr_t_exp123
    {
      filen      = Filen;
      Objecttype = objecttype;
      Text       = text;
    }

  delete;
  update;

  field ( readonly ) TextName, Filen, ObjectType;
  association _ExportFile;
}

define behavior for ZETR_DDL_I_BIL_DOC
late numbering
with unmanaged save
lock dependent by _ExportFile
authorization dependent by _ExportFile
{
  action releaseToAccountingBilDoc;


  field ( readonly ) FileExportNo;
  association _ExportFile;
}

define behavior for ZETR_DDL_I_COSTING
late numbering
with unmanaged save
lock dependent by _ExportFile
authorization dependent by _ExportFile
{
  action releaseToAccountingBilDoc;


  field ( readonly ) Filen;
  association _ExportFile;
}