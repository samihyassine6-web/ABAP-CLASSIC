*&---------------------------------------------------------------------*
*& Report ZPRG_FIELD_SYMBOLS_AS_WO_AREA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_field_symbols_as_wo_area.

DATA: lv_ono TYPE zdeono_28.

TYPES: BEGIN OF lty_ordh,
         ono TYPE zdeono_28,
         pm  TYPE zdepm_28,
         ta  TYPE zdeta_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
DATA: lwa_ordh TYPE lty_ordh.
FIELD-SYMBOLS: <fs_ordh> TYPE lty_ordh.

SELECT-OPTIONS: s_ono FOR lv_ono.

SELECT ono pm ta
  FROM zordh_28
  INTO TABLE lt_ordh
  WHERE ono IN s_ono.


*LOOP AT lt_ordh INTO lwa_ordh.
*  WRITE: / lwa_ordh-ono, lwa_ordh-pm, lwa_ordh-ta.
*ENDLOOP.

READ TABLE lt_ordh INTO lwa_ordh WITH KEY ono = 1.
IF sy-subrc = 0.
  WRITE: / lwa_ordh-ono, lwa_ordh-pm, lwa_ordh-ta.
ENDIF.

READ TABLE lt_ordh ASSIGNING <fs_ordh> WITH KEY ono = 1.
IF <fs_ordh> IS ASSIGNED.
  WRITE: / <fs_ordh>-ono, <fs_ordh>-pm, <fs_ordh>-ta.
ENDIF.


*LOOP AT lt_ordh ASSIGNING <fs_ordh> .
*  IF <fs_ordh> IS ASSIGNED.
*    WRITE: / <fs_ordh>-ono, <fs_ordh>-pm, <fs_ordh>-ta.
*  ENDIF.
*ENDLOOP.
