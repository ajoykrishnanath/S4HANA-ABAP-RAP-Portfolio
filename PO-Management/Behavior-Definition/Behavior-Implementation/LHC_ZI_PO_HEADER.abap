CLASS lhc_zi_po_header DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_po_header RESULT result.

    METHODS CalculateTotal
      FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_po_item~CalculateTotal.

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
