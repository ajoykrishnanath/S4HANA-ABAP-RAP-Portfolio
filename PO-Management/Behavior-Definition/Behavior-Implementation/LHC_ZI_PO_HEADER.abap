CLASS lhc_zi_po_header DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_po_header RESULT result.

    METHODS ValidateVendor
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_po_header~ValidateVendor.

    METHODS ValidatePODate
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_po_header~ValidatePODate.

    METHODS SetDefaultValues
      FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_po_header~SetDefaultValues.

    METHODS SubmitPO
      FOR MODIFY
      IMPORTING keys   FOR ACTION zi_po_header~SubmitPO
      RESULT    result.

ENDCLASS.

CLASS lhc_zi_po_header IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zi_po_header IN LOCAL MODE
    ENTITY zi_po_header
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_header).

    result = VALUE #(
      FOR ls_header IN lt_header
      (
        %tky = ls_header-%tky

        %update =
          COND #(
            WHEN ls_header-Status = 'S'
            THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled )

        %delete =
          COND #(
            WHEN ls_header-Status = 'S'
            THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled )

        %action-SubmitPO =
          COND #(
            WHEN ls_header-Status = 'S'
            THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled )

        %assoc-_Item =
          COND #(
            WHEN ls_header-Status = 'S'
            THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled )
      )
    ).
  ENDMETHOD.

  METHOD validatevendor.

    READ ENTITIES OF zi_po_header IN LOCAL MODE
    ENTITY zi_po_header
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_header).

    LOOP AT lt_header ASSIGNING FIELD-SYMBOL(<ls_header>).

      IF <ls_header>-VendorId IS INITIAL.

        APPEND VALUE #(
          %tky = <ls_header>-%tky
        ) TO failed-zi_po_header.

        APPEND VALUE #(
          %tky = <ls_header>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Vendor is mandatory'
                 )
        ) TO reported-zi_po_header.

        CONTINUE.

      ENDIF.
      SELECT SINGLE lifnr
        FROM lfa1
        WHERE lifnr = @<ls_header>-VendorId
        INTO @DATA(lv_lifnr).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = <ls_header>-%tky
        ) TO failed-zi_po_header.

        APPEND VALUE #(
          %tky = <ls_header>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = |Vendor { <ls_header>-VendorId } does not exist|
                 )
        ) TO reported-zi_po_header.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD ValidatePODate.

    READ ENTITIES OF zi_po_header IN LOCAL MODE
      ENTITY zi_po_header
      FIELDS ( PO_Date )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_header).

    LOOP AT lt_header ASSIGNING FIELD-SYMBOL(<ls_header>).

      IF <ls_header>-PO_Date >
         cl_abap_context_info=>get_system_date( ).

        APPEND VALUE #(
          %tky = <ls_header>-%tky
        ) TO failed-zi_po_header.

        APPEND VALUE #(
          %tky = <ls_header>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'PO Date cannot be in the future'
                 )
        ) TO reported-zi_po_header.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD setdefaultvalues.
    GET TIME STAMP FIELD DATA(lv_timestamp).

    MODIFY ENTITIES OF zi_po_header IN LOCAL MODE
      ENTITY zi_po_header
      UPDATE FIELDS ( Status Created_On )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky       = key-%tky
          Status     = 'N'
          Created_On = lv_timestamp
        )
      ).
  ENDMETHOD.

  METHOD submitpo.
    MODIFY ENTITIES OF zi_po_header IN LOCAL MODE
    ENTITY zi_po_header
    UPDATE FIELDS ( Status )
    WITH VALUE #(
      FOR key IN keys
      (
        %tky   = key-%tky
        Status = 'SUBMITTED'
      )
    ).

    READ ENTITIES OF zi_po_header IN LOCAL MODE
      ENTITY zi_po_header
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR ls_result IN lt_result
      (
        %tky   = ls_result-%tky
        %param = ls_result
      )
    ).
  ENDMETHOD.

ENDCLASS.
