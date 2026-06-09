@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for PO header'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
    typeName: 'Purchase Order',
    typeNamePlural: 'Purchase Orders',
    title: { value: 'POId' }
//    typeImageUrl: '',
//    imageUrl: '',
//    title: {
//        type: #STANDARD,
//        label: '',
//        iconUrl: '',
//        criticality: '',
//        criticalityRepresentation: #WITHOUT_ICON,
//        value: 'PO_Id',
//        valueQualifier: '',
//        targetElement: '',
//        url: ''
//    },
//    description: {
//        type: #STANDARD,
//        label: '',
//        iconUrl: '',
//        criticality: '',
//        criticalityRepresentation: #WITHOUT_ICON,
//        value: '',
//        valueQualifier: '',
//        targetElement: '',
//        url: ''
//    }
}

define root view entity ZAN_C_PO_Header 
as projection on ZI_PO_HEADER

//composition of target_data_source_name as _association_name
{
    key PO_Id,
    
    @UI.lineItem: [{ position: 10 }]
    @UI.identification: [{ position: 10 }]
    VendorId,
    
    @UI.lineItem: [{ position: 20 }]
    @UI.identification: [{ position: 20 }]
    PO_Date,
    
    @UI.lineItem: [{ position: 30 }]
    @UI.identification: [{ position: 30 }]
    Status,
    
    @UI.lineItem: [{ position: 40 }]
    @Semantics.amount.currencyCode: 'Currency'
    FT_Amount,
    
    @UI.lineItem: [{ position: 50 }]
    Currency,
    
    @UI.lineItem: [{ position: 60 }]
    Created_By,
    
    @UI.hidden: true
    Created_On,
    
    /* Association for navigation */
    _Item: redirected to composition child ZAN_C_PO_Item
}
