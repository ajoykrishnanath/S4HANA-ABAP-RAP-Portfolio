//@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for PO Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_PO_HEADER as select from zpo_header

association [0..*] to zpo_item as _Item
on $projection.PO_Id = _Item.po_id
{
    key po_id as PO_Id,
    vid as VendorId,
    po_date as PO_Date,
    status as Status,
    @Semantics.amount.currencyCode: 'Currency'
    netpr as Amount,
    waers as Currency,
    syuname as Created_By,
    timestamp as Created_On,
    
//    _association_name // Make association public
    _Item
}
