@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer value help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_588437_CustomerVH as select from ZI_588437_Customer
{
  key CustomerId,
  FirstName,
  LastName,
  Title,
  Street,
  PostalCode,
  City,
  CountryCode
}
