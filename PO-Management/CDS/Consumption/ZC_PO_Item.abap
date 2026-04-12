@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for PO Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_PO_Item as select from ZI_PO_ITEM
{
    key PO_Id,
    key Item,
    
    @UI.lineItem: [{ position: 10 }]
    Material,
    
    @UI.lineItem: [{ position: 20 }]
    @Semantics.quantity.unitOfMeasure: 'Unit'
    Quantity,
    
    @UI.lineItem: [{ position: 30 }]
    Unit,
    
    @UI.lineItem: [{ position: 40 }]
    @Semantics.amount.currencyCode: 'Currency'
    Amount,
    
    @UI.lineItem: [{ position: 50 }]
    Currency,
    
    @UI.lineItem: [{ position: 60 }]
    @Semantics.amount.currencyCode: 'Currency'
    Total_Amount,
    
    /* Associations */
    _Header
}
