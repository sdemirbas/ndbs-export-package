abstract;
strict ( 2 );
with hierarchy;

define behavior for Zetr_ABS_ROOT_PARAM //alias <alias_name>
{

  field ( suppress ) dummy;
  deep mapping for zetr_s_costing_types
    {
      sub _Table  = table;
      sub _Table2 = table2;
    }

  association _Table;
  association _table2;
}

define behavior for ZETR_ABS_ITEM_FIELDS //alias <alias_name>
{

  field ( suppress ) dummy;

  deep mapping for zetr_s_costing_items
    {
      costing_type        = costing_type;
      document_no         = document_no;
      item_no             = item_no;
      ba_type             = ba_type;
      gcb_no              = gcb_no;
      cost_center         = cost_center;
      product             = product;
      net_weight          = net_weight;
      volume              = volume;
      invoice_amount      = invoice_amount;
      invoice_amount_unit = invoice_amount_unit;
      cost_amount         = cost_amount;
      tax_type            = tax_type;
      text                = text;
      tax_amount          = tax_amount;
    }


  association _Header;
}

define behavior for ZETR_ABS_costing_header_fields
{

  field ( suppress ) dummy;

  deep mapping for zetr_s_costing_header
    {
      document_date = document_date;
      created_date  = created_date;
      amount        = amount;
      waers         = waers;
      tax_amount    = tax_amount;
      text          = text;
      company_code  = company_Code;
      supplier      = supplier;
      process       = process;
      document_type = document_type;
      exchange_rate = exchange_rate;
    }

  association _Header;


}