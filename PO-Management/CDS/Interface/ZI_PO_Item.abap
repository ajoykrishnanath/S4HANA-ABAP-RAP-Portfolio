@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for PO Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PO_ITEM as select from zpo_item

association [1..1] to zpo_header as _Header
on $projection.PO_Id = _Header.po_id
{
    key po_id as PO_Id,
    key ebelp as Item,
    matnr as Material,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    menge as Quantity,
    meins as Unit,
    @Semantics.amount.currencyCode: 'Currency'
    netpr as Amount,
    waers as Currency,
    @Semantics.amount.currencyCode: 'Currency'
    netwr as Total_Amount,  
    
//    _association_name // Make association public
    _Header
}
