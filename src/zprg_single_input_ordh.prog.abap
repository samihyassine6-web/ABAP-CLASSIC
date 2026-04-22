*&---------------------------------------------------------------------*
*& Report ZPRG_SINGLE_INPUT_ORDH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_single_input_ordh.

DATA: lv_ono   TYPE zdeono_28,
      lv_odate TYPE zdeodate_28,
      lv_ta    TYPE zdeta_28,
      lv_curr  TYPE zdecurr_28.

* Single Selection
*---------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
PARAMETERS: p_ono TYPE zdeono_28.
SELECTION-SCREEN END OF BLOCK b1.

TYPES: BEGIN OF lty_ordh_28,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         ta    TYPE zdeta_28,
         curr  TYPE zdecurr_28,
       END OF lty_ordh_28.

DATA: lt_ordh_28 TYPE TABLE OF lty_ordh_28.
DATA: lwa_ordh_28 TYPE  lty_ordh_28.

*SELECT ono odate ta curr
*  FROM zordh_28
*  INTO TABLE lt_ordh_28
*  WHERE ono = p_ono.

SELECT SINGLE ono odate ta curr
  FROM zordh_28
  INTO ( lv_ono, lv_odate, lv_ta, lv_curr )
  WHERE ono = p_ono.

  IF sy-subrc = 0.
    WRITE: / lv_ono, lv_odate, lv_ta, lv_curr.
  ENDIF.



*SELECT SINGLE ono odate ta curr
*  FROM zordh_28
*  INTO  lwa_ordh_28
*  WHERE ono = p_ono.
*
*IF sy-subrc = 0.
*  WRITE: / lwa_ordh_28-ono, lwa_ordh_28-odate, lwa_ordh_28-ta, lwa_ordh_28-curr.
*ENDIF.


*IF sy-subrc <> 0.
*  WRITE: 'Order Number does not exist', p_ono.
*ELSE.
*  LOOP AT lt_ordh_28 INTO lwa_ordh_28.
*    WRITE: / lwa_ordh_28-ono, lwa_ordh_28-odate, lwa_ordh_28-ta, lwa_ordh_28-curr.
*  ENDLOOP.
*ENDIF.

**READ TABLE lt_ordh_28 INTO lwa_ordh_28 INDEX 1 .
*READ TABLE lt_ordh_28 INTO lwa_ordh_28 WITH KEY p_ono .
*IF sy-subrc = 0.
*  WRITE: / lwa_ordh_28-ono, lwa_ordh_28-odate, lwa_ordh_28-ta, lwa_ordh_28-curr.
*ELSE.
*  WRITE: 'Order Number does not exist', p_ono.
*ENDIF.
