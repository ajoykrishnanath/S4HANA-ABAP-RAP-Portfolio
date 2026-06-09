managed implementation in class zbp_i_po_header unique;
//strict ( 2 );

define behavior for ZI_PO_HEADER //alias <alias_name>
persistent table zan_po_header
lock master
//authorization master ( instance )
//etag master <field_name>
{
  create;
  update;
  delete;
  association _Item { create; }
  field ( readonly ) PO_Id;
}

define behavior for ZI_PO_ITEM //alias <alias_name>
persistent table zan_po_item
lock dependent by _Header
//authorization dependent by _Header
//etag master <field_name>
{
  update;
  delete;
  field ( readonly ) PO_Id, Item;
  association _Header;
}
