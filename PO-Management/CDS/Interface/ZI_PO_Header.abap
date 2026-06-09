@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for PO Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_PO_HEADER as select from zan_po_header

composition [0..*] of ZI_PO_ITEM as _Item

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
