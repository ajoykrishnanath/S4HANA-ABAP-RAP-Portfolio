//@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for PO Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_PO_HEADER as select from zpo_header

association [0..*] to ZI_PO_ITEM as _Item
on $projection.PO_Id = _Item.PO_Id

association [0..1] to ZI_PO_IT_Total as _total
on $projection.PO_Id = _total.PO_Id

{
    key po_id as PO_Id,
    vid as VendorId,
    po_date as PO_Date,
    status as Status,
    
    @Semantics.amount.currencyCode: 'Currency'
    _total.FT_Amount,
    waers as Currency,
    
    syuname as Created_By,
    timestamp as Created_On,
    
//    _association_name // Make association public
    _Item
}
