@EndUserText.label : 'Draft table for entity ZI_PO_ITEM'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zan_dpo_item {

  key po_id    : ebeln not null;
  key item     : ebelp not null;
  material     : matnr;
  @Semantics.quantity.unitOfMeasure : 'zan_dpo_item.unit'
  quantity     : menge_d;
  unit         : meins;
  @Semantics.amount.currencyCode : 'zan_dpo_item.currency'
  amount       : netpr;
  currency     : waers;
  @Semantics.amount.currencyCode : 'zan_dpo_item.currency'
  total_amount : netwr;
  "%admin"     : include sych_bdl_draft_admin_inc;

}
