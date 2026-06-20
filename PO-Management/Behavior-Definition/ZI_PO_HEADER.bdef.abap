managed implementation in class zbp_i_po_header unique;
with draft;
//strict ( 2 );

define behavior for ZI_PO_HEADER //alias <alias_name>
persistent table zan_po_header
draft table zan_dpo_header
lock master total etag Created_On
//lock master
//authorization master ( instance )
//etag master Created_On
{
  create;
  update;
  delete;
  association _Item { create; with draft; }
//  association _Item { create; }
  field ( readonly ) PO_Id;
}

define behavior for ZI_PO_ITEM //alias <alias_name>
persistent table zan_po_item
draft table zan_dpo_item
lock dependent by _Header
//authorization dependent by _Header
//etag master <field_name>
{
//  create;
  update;
  delete;
  field ( readonly ) PO_Id, Item;
  association _Header { with draft; }
//  association _Header;
}
