@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for PO header'
//@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZAN_C_PO_Header
as projection on ZI_PO_HEADER

{
    key PO_Id,
    
    VendorId,
    
    PO_Date,
    
    Status,
    
    @Semantics.amount.currencyCode: 'Currency'
    FT_Amount,
    
    Currency,
    
    Created_By,
    
    Created_On,
    
    /* Association for navigation */
    _Item: redirected to composition child ZAN_C_PO_Item
}
