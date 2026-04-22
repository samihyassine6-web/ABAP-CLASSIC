*&---------------------------------------------------------------------*
*& Report ZPRG_FIELD_SYMBOLS_MODIFY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_field_symbols_as_append.

DATA: lv_ono TYPE zdeono_28.

TYPES: BEGIN OF lty_ordh,
         ono TYPE zdeono_28,
         pm  TYPE zdepm_28,
         ta  TYPE zdeta_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
DATA: lwa_ordh TYPE lty_ordh.
FIELD-SYMBOLS: <fs_ordh> TYPE lty_ordh.

*lwa_ordh-ono = '1'.
*lwa_ordh-pm  = 'C'.
*lwa_ordh-ta = '1300.00'.
*APPEND lwa_ordh TO  lt_ordh.
*CLEAR lwa_ordh.
*
*lwa_ordh-ono = '2'.
*lwa_ordh-pm  = 'D'.
*lwa_ordh-ta = '1350.00'.
*APPEND lwa_ordh TO  lt_ordh.
*CLEAR lwa_ordh.
*
*lwa_ordh-ono = '3'.
*lwa_ordh-pm  = 'D'.
*lwa_ordh-ta = '1200.00'.
*APPEND lwa_ordh TO  lt_ordh.
*CLEAR lwa_ordh.
*
*lwa_ordh-ono = '4'.
*lwa_ordh-pm  = 'N'.
*lwa_ordh-ta = '1500.00'.
*APPEND lwa_ordh TO  lt_ordh.
*CLEAR lwa_ordh.
*
*lwa_ordh-ono = '5'.
*lwa_ordh-pm  = 'C'.
*lwa_ordh-ta = '1800.00'.
*APPEND lwa_ordh TO  lt_ordh.
*CLEAR lwa_ordh.
*
*LOOP AT lt_ordh INTO lwa_ordh.
*  WRITE: / lwa_ordh-ono, lwa_ordh-pm, lwa_ordh-ta.
*ENDLOOP.

* Append Records using Field Symbols
*-------------------------------------------------*

APPEND INITIAL LINE TO lt_ordh ASSIGNING <fs_ordh>.   " Insert a blanc line to the internal table and assigning to field symbol
IF <fs_ordh> IS ASSIGNED.
  <fs_ordh>-ono = '1'.
  <fs_ordh>-pm  = 'C'.
  <fs_ordh>-ta = '1300.00'.
  UNASSIGN <fs_ordh>.
ENDIF.

APPEND INITIAL LINE TO lt_ordh ASSIGNING <fs_ordh>.
IF <fs_ordh> IS ASSIGNED.
  <fs_ordh>-ono = '2'.
  <fs_ordh>-pm  = 'C'.
  <fs_ordh>-ta = '1400.00'.
  UNASSIGN <fs_ordh>.
ENDIF.

APPEND INITIAL LINE TO lt_ordh ASSIGNING <fs_ordh>.
IF <fs_ordh> IS ASSIGNED.
  <fs_ordh>-ono = '3'.
  <fs_ordh>-pm  = 'N'.
  <fs_ordh>-ta = '1450.00'.
  UNASSIGN <fs_ordh>.
ENDIF.

APPEND INITIAL LINE TO lt_ordh ASSIGNING <fs_ordh>.
IF <fs_ordh> IS ASSIGNED.
  <fs_ordh>-ono = '4'.
  <fs_ordh>-pm  = 'D'.
  <fs_ordh>-ta = '1300.00'.
  UNASSIGN <fs_ordh>.
ENDIF.

APPEND INITIAL LINE TO lt_ordh ASSIGNING <fs_ordh>.
IF <fs_ordh> IS ASSIGNED.
  <fs_ordh>-ono = '5'.
  <fs_ordh>-pm  = 'N'.
  <fs_ordh>-ta = '1300.00'.
  UNASSIGN <fs_ordh>.
ENDIF.

LOOP AT lt_ordh ASSIGNING <fs_ordh>.
  IF <fs_ordh> IS ASSIGNED.
    WRITE: / <fs_ordh>-ono, <fs_ordh>-pm, <fs_ordh>-ta.
  ENDIF.
ENDLOOP.
