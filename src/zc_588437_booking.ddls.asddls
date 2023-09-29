@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking zc'
@Metadata.allowExtensions: true
define view entity ZC_588437_Booking 
  as projection on ZR_588437_Booking
{
  key BookingUuid,
  TravelUuid,
  BookingId,
  BookingDate,
  CustomerId,
  CarrierId,
  ConnectionId,
  FlightDate,
  FlightPrice,
  CurrencyCode,
  /* Associations */
  _Travel : redirected to parent ZC_588437_Travel
}
