CLASS lhc_zi_po_header DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_po_header RESULT result.

    METHODS CalculateTotal
      FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_po_item~CalculateTotal.

    METHODS ValidateVendor
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_po_header~ValidateVendor.

    METHODS ValidateItem
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_po_item~ValidateItem.

ENDCLASS.

CLASS lsc_zi_po_header DEFINITION
  INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.
    TYPES:
      BEGIN OF ty_counter,
        po_id     TYPE ebeln,
        next_item TYPE ebelp,
      END OF ty_counter.

    DATA:
      lt_counter  TYPE STANDARD TABLE OF ty_counter.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lhc_zi_po_header IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD calculatetotal.

    READ ENTITIES OF zi_po_header IN LOCAL MODE
    ENTITY zi_po_item
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    MODIFY ENTITIES OF zi_po_header IN LOCAL MODE
      ENTITY zi_po_item
      UPDATE FIELDS ( Total_Amount )
      WITH VALUE #(
        FOR ls_item IN lt_item
        (
          %tky         = ls_item-%tky
          Total_Amount = ls_item-Quantity * ls_item-Amount
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

  METHOD validateitem.

    READ ENTITIES OF zi_po_header IN LOCAL MODE
    ENTITY zi_po_item
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<ls_item>).

* Material Validation
      SELECT SINGLE matnr
        FROM mara
        WHERE matnr = @<ls_item>-Material
        INTO @DATA(lv_matnr).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
        ) TO failed-zi_po_item.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = |Material { <ls_item>-Material } does not exist|
                 )
        ) TO reported-zi_po_item.

      ENDIF.

* Quantity Validation
      IF <ls_item>-Quantity <= 0.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
        ) TO failed-zi_po_item.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Quantity must be greater than 0'
                 )
        ) TO reported-zi_po_item.

      ENDIF.

* Unit Validation
      SELECT SINGLE msehi
        FROM t006
        WHERE msehi = @<ls_item>-Unit
        INTO @DATA(lv_unit).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
        ) TO failed-zi_po_item.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = |Unit { <ls_item>-Unit } does not exist|
                 )
        ) TO reported-zi_po_item.

      ENDIF.

* Currency Validation
      SELECT SINGLE waers
        FROM tcurc
        WHERE waers = @<ls_item>-Currency
        INTO @DATA(lv_currency).

      IF sy-subrc <> 0.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
        ) TO failed-zi_po_item.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = |Currency { <ls_item>-Currency } does not exist|
                 )
        ) TO reported-zi_po_item.

      ENDIF.

* Amount Validation
      IF <ls_item>-Amount <= 0.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
        ) TO failed-zi_po_item.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Amount must be greater than 0'
                 )
        ) TO reported-zi_po_item.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_po_header IMPLEMENTATION.

  METHOD adjust_numbers.

    DATA lv_po TYPE ebeln.

    LOOP AT mapped-zi_po_header ASSIGNING FIELD-SYMBOL(<ls_header>).

      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr = '01'
          object      = 'ZAN_PO'
        IMPORTING
          number      = lv_po
        EXCEPTIONS
          OTHERS      = 1.

      IF sy-subrc = 0.

        <ls_header>-PO_Id = lv_po.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
