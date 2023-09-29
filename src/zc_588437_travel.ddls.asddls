@EndUserText.label: 'c travel'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_588437_Travel
  provider contract transactional_query
  as projection on ZR_588437_Travel
{
  key TravelUuid,
      TravelId,
      AgencyId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_588437_CustomerVH', element: 'CustomerId'}}]
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH', element: 'Currency' }}]
      CurrencyCode,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Description,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_588437_StatusVH', element: 'Status'}}]
      Status,

      //Admin Data
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      
      //Transient Data
      StatusCriticality,
      BeginDateCriticality,
      _CustomerText.CustomerName as CustomerName,

      //Association
      _Bookings : redirected to composition child ZC_588437_Booking

}
