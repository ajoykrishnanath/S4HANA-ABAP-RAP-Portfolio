@EndUserText.label : 'Draft table for entity ZI_PO_HEADER'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zan_dpo_header {

  key po_id  : ebeln not null;
  vendorid   : lifnr;
  po_date    : dats;
  status     : z_stat;
  @Semantics.amount.currencyCode : 'zan_dpo_header.currency'
  ft_amount  : abap.curr(15,2);
  currency   : waers;
  created_by : syuname;
  created_on : timestamp;
  "%admin"   : include sych_bdl_draft_admin_inc;

}
