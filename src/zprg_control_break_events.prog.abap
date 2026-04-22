*&---------------------------------------------------------------------*
*& Report ZPRG_CONTROL_BREAK_EVENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_control_break_events.

DATA: lv_pm TYPE zdepm_28.

TYPES: BEGIN OF lty_data,
         ono TYPE zdeono_28,
         pm  TYPE zdepm_28,
         ta  TYPE zdeta_28,
       END OF lty_data.

DATA: lt_data TYPE TABLE OF lty_data.
DATA: lwa_data TYPE lty_data.

TYPES: BEGIN OF lty_temp_data,
         pm  TYPE zdepm_28,
         ono TYPE zdeono_28,
         ta  TYPE zdeta_28,
       END OF lty_temp_data.

DATA: lt_temp_data TYPE TABLE OF lty_temp_data.
DATA: lwa_temp_data TYPE lty_temp_data.
DATA: lwa_temp TYPE lty_temp_data.


SELECTION-SCREEN BEGIN OF BLOCK blk WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_pm FOR lv_pm NO INTERVALS..
SELECTION-SCREEN END OF BLOCK blk.

SELECT ono pm ta
  FROM zordh_28
  INTO TABLE lt_data
  WHERE pm IN s_pm.

LOOP AT lt_data INTO lwa_data.
  lwa_temp_data-pm = lwa_data-pm.
  lwa_temp_data-ono = lwa_data-ono.
  lwa_temp_data-ta = lwa_data-ta.
  APPEND: lwa_temp_data TO lt_temp_data.
  CLEAR: lwa_temp_data.
ENDLOOP.

SORT: lt_temp_data BY pm. " Condition for usage of control break statments

LOOP AT lt_temp_data INTO lwa_temp_data.
  lwa_temp = lwa_temp_data.
  AT FIRST.
    WRITE: / sy-uline(100).
    WRITE: / sy-vline,  TEXT-001, text-003, lwa_temp-ono, 100 sy-vline.
    WRITE: / sy-uline(100).
  ENDAT.

  AT NEW pm.
    WRITE: / sy-uline(5).
    WRITE: / sy-vline, lwa_temp_data-pm, 5 sy-vline.
    WRITE: / sy-uline(5).
  ENDAT.

  AT END OF pm.
    SUM.          " SUM calculates the sum of all numeric fields to the right of current group key.
    WRITE: lwa_temp_data-ta.
  ENDAT.
  AT LAST.
    WRITE: / sy-uline(50).
    WRITE: / sy-vline, TEXT-002, text-003, lwa_temp-ono, 50 sy-vline.
    WRITE: / sy-uline(50).
  ENDAT.
ENDLOOP.
