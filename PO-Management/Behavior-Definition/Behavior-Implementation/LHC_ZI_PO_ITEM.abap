CLASS lhc_zi_po_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features
        FOR INSTANCE FEATURES
        IMPORTING keys REQUEST requested_features
        FOR zi_po_item RESULT result.

    METHODS CalculateTotal
      FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_po_item~CalculateTotal.

    METHODS ValidateItem
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_po_item~ValidateItem.

ENDCLASS.

CLASS lhc_zi_po_item IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zi_po_header IN LOCAL MODE
    ENTITY zi_po_item
    FIELDS ( PO_Id )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    result = VALUE #( ).

    LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<ls_item>).

      SELECT SINGLE status
        FROM zan_po_header
        WHERE po_id = @<ls_item>-PO_Id
        INTO @DATA(lv_status).

      APPEND VALUE #(
        %tky = <ls_item>-%tky

        %update =
          COND #(
            WHEN lv_status = 'S'
            THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled )

        %delete =
          COND #(
            WHEN lv_status = 'S'
            THEN if_abap_behv=>fc-o-disabled
            ELSE if_abap_behv=>fc-o-enabled )

      ) TO result.

    ENDLOOP.
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

  METHOD validateitem.

    READ ENTITIES OF zi_po_header IN LOCAL MODE
    ENTITY zi_po_item
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<ls_item>).

      SELECT SINGLE status
    FROM zan_po_header
    WHERE po_id = @<ls_item>-PO_Id
    INTO @DATA(lv_status).

      IF lv_status = 'S'.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
        ) TO failed-zi_po_item.

        APPEND VALUE #(
          %tky = <ls_item>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Items cannot be modified for a submitted PO'
                 )
        ) TO reported-zi_po_item.

        CONTINUE.

      ENDIF.

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
