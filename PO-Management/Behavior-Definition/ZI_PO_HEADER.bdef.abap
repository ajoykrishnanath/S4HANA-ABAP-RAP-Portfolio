managed implementation in class zbp_i_po_header unique;
with draft;
//strict ( 2 );

define behavior for ZI_PO_HEADER //alias <alias_name>
late numbering
persistent table zan_po_header
draft table zan_dpo_header
lock master total etag Created_On
//lock master
//authorization master ( instance )
//etag master Created_On
{
  mapping for zan_po_header
    {
      PO_Id      = po_id;
      VendorId   = vid;
      PO_Date    = po_date;
      FT_Amount  = netpr;
      Currency   = waers;
      Status     = status;
      Created_By = syuname;
      Created_On = timestamp;
    }
  create;
  update;
  delete;
  association _Item { create; with draft; }
  field ( readonly ) PO_Id;

  //  determination GeneratePOnum on save { create; }
}

define behavior for ZI_PO_ITEM //alias <alias_name>
late numbering
persistent table zan_po_item
draft table zan_dpo_item
lock dependent by _Header
//authorization dependent by _Header
//etag master <field_name>
{
  mapping for zan_po_item
    {
      PO_Id        = po_id;
      Item         = ebelp;
      Material     = matnr;
      Quantity     = menge;
      Unit         = meins;
      Amount       = netpr;
      Total_Amount = netwr;
      Currency     = waers;
    }
  update;
  delete;

  determination CalculateTotal on modify
  {
    create;
    field Quantity, Amount;
  }

//  side effects
//  {
//    field Quantity affects field Total_Amount;
//    field Amount affects field Total_Amount;
//  }

  field ( readonly ) PO_Id, Total_Amount;
  association _Header { with draft; }
}
