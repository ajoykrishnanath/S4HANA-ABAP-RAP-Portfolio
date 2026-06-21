CLASS lhc_zi_po_header DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_po_header RESULT result.

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
