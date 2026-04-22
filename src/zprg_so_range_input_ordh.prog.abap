*&---------------------------------------------------------------------*
*& Report ZPRG_SO_RANGE_INPUT_ORDH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_so_range_input_ordh.

DATA: lv_ono TYPE zdeono_28.

* Range Selection
*---------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_ono FOR lv_ono.
SELECTION-SCREEN END OF BLOCK b1.

TYPES: BEGIN OF lty_ordh_28,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         ta    TYPE zdeta_28,
         curr  TYPE zdecurr_28,
       END OF lty_ordh_28.

DATA: lt_ordh_28 TYPE TABLE OF lty_ordh_28.
DATA: lwa_ordh_28 TYPE  lty_ordh_28.


SELECT ono odate ta curr
  FROM zordh_28
  INTO TABLE lt_ordh_28
  WHERE ono IN s_ono.


IF sy-subrc <> 0.
  WRITE: 'Range of Order Number does not exist', s_ono-low, s_ono-high, s_ono-sign, s_ono-option.
ELSE.
  LOOP AT lt_ordh_28 INTO lwa_ordh_28.
    WRITE: / lwa_ordh_28-ono, lwa_ordh_28-odate, lwa_ordh_28-ta, lwa_ordh_28-curr.
  ENDLOOP.
ENDIF.
