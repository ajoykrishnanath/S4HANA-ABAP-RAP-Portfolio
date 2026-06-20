@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for PO Item'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZAN_C_PO_Item 
as projection on ZI_PO_ITEM
{
    key PO_Id,
    key Item,
    
    Material,
    
    @Semantics.quantity.unitOfMeasure: 'Unit'
    Quantity,
    
    Unit,
    
    @Semantics.amount.currencyCode: 'Currency'
    Amount,
    
    Currency,
    
    @Semantics.amount.currencyCode: 'Currency'
    Total_Amount,
    
    _Header: redirected to parent ZAN_C_PO_Header
}
