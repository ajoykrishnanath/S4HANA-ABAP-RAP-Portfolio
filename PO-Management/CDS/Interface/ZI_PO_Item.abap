@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for PO Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PO_ITEM as select from zan_po_item

association to parent ZI_PO_HEADER as _Header
on $projection.PO_Id = _Header.PO_Id
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
