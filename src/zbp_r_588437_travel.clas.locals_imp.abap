CLASS lhc_ZR_588437_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS show_test_message FOR MODIFY
      IMPORTING keys FOR ACTION travel~show_test_message.
    METHODS cancel_booking FOR MODIFY
      IMPORTING keys FOR ACTION travel~cancel_booking.
    METHODS maintain_booking_fees FOR MODIFY
      IMPORTING keys FOR ACTION travel~maintain_booking_fees.

ENDCLASS.

CLASS lhc_ZR_588437_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD show_test_message.

    DATA(message) = NEW zcm_588437_travel(
      i_textid    = zcm_588437_travel=>test_message
      i_severity  = if_abap_behv_message=>severity-information
      i_user_name = sy-uname
    ).
    APPEND message TO reported-%other.

  ENDMETHOD.

  METHOD cancel_booking.

    "Ausgewählte Daten (Reisen) lesen
    READ ENTITY IN LOCAL MODE zr_588437_travel
      FIELDS ( TravelUuid Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).
    "SELECT FROM zda588437_travel
    "Field TravelUuid, Status
    "Where TravelUuid in key
    "Into Table @DATA(travels).


    "Über die Daten (Reisen) iterien
    LOOP AT travels REFERENCE INTO DATA(travel).

      "Validieren
      IF travel->Status = 'X'.
        DATA(message) = NEW zcm_588437_travel(
        i_textid    = zcm_588437_travel=>travel_already_cancelled
        i_severity  = if_abap_behv_message=>severity-error
        i_travel = travel->Description ).
        APPEND VALUE #( %tky = travel->%tky %msg = message ) TO reported-travel.
        APPEND VALUE #( %tky = travel->%tky ) TO failed-travel.
        CONTINUE.

      ENDIF.

      "Daten (Reisen)  ändern und gegebenenfalls Nachrichten erzeugen
      travel->Status = 'X'.

      message = NEW zcm_588437_travel(
      i_textid    = zcm_588437_travel=>travel_cancelled_successfully
      i_severity  = if_abap_behv_message=>severity-success
      i_travel = travel->Description
    ).
      APPEND VALUE #( %tky = travel->%tky %msg = message ) TO reported-travel.
      "Daten (Reisen zurückschreiben
      MODIFY ENTITY IN LOCAL MODE zr_588437_Travel
        UPDATE FIELDS ( status )
        WITH VALUE #( ( %tky = travel->%tky Status = travel->Status ) ).

    ENDLOOP.

  ENDMETHOD.

  METHOD maintain_booking_fees.

    READ ENTITY IN LOCAL MODE ZR_588437_Travel
      FIELDS ( TravelUuid )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    LOOP AT travels REFERENCE INTO DATA(travel).

      travel->BookingFee = keys[ sy-tabix ]-%param-BookingFee.
      travel->CurrencyCode = keys[ sy-tabix ]-%param-CurrencyCode.

      MODIFY ENTITY IN LOCAL MODE ZR_588437_Travel
      UPDATE FIELDS ( BookingFee CurrencyCode )
      WITH VALUE #( ( %tky = travel->%tky
                      BookingFee = travel->BookingFee
                      CurrencyCode = travel->CurrencyCode ) ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
