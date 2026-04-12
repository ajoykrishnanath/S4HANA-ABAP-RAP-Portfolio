@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Final Total Amount of PO Id'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PO_IT_Total as select from ZI_PO_ITEM
{
    key PO_Id,
    
    @Semantics.amount.currencyCode: 'Currency'
    @Aggregation.default: #SUM
    sum( Total_Amount ) as FT_Amount,
    Currency
} group by 
    PO_Id,
    Currency
