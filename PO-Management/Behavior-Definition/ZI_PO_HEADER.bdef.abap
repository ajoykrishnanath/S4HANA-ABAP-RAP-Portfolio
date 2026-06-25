managed implementation in class zbp_i_po_header unique;
with draft;

define behavior for ZI_PO_HEADER //alias <alias_name>
late numbering
persistent table zan_po_header
draft table zan_dpo_header
lock master total etag Created_On
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
  update ( features : instance );
  delete ( features : instance );
  association _Item { create ( features : instance ); with draft; }
  field ( readonly ) PO_Id, Status, FT_Amount, Created_On;
  field ( mandatory ) VendorId;

  action ( features : instance ) SubmitPO result [1] $self;

  determination SetDefaultValues on modify
  {
    create;
  }

  validation ValidateVendor on save     //Validate VendorId from LFA1
  {
    create; update;
  }

  validation ValidatePODate on save
  {
    field PO_Date;
  }
}

define behavior for ZI_PO_ITEM //alias <alias_name>
late numbering
persistent table zan_po_item
draft table zan_dpo_item
lock dependent by _Header
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
  update ( features : instance );
  delete ( features : instance );

  determination CalculateTotal on modify
  {
    create;
    field Quantity, Amount;
  }

  validation ValidateItem on save
  {
    field Material, Quantity, Unit, Amount, Currency;
  }

  validation ValidateSubmittedPO on save
  {
    create;
    update;
  }

  field ( readonly ) PO_Id, Total_Amount;
  association _Header { with draft; }
}
