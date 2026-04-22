*&---------------------------------------------------------------------*
*& Report ZPRG_INTERACTIVE_CLASS_HIDE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_interactive_class_hide.

DATA: lv_ono TYPE zdeono_28.
DATA: lv_lines TYPE i.
DATA: lv_lines1 TYPE i.


TYPES: BEGIN OF lty_ordh,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         pm    TYPE zdepm_28,
         ta    TYPE zdeta_28,
         curr  TYPE zdecurr_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
DATA: lwa_ordh TYPE lty_ordh.

TYPES: BEGIN OF lty_ordi,
         ono   TYPE zdeono_28,
         oin   TYPE zdeoin_28,
         odesc TYPE zdeodesc_28,
         icost TYPE zdeicost_28,
       END OF lty_ordi.

DATA: lt_ordi TYPE TABLE OF lty_ordi.
DATA: lwa_ordi TYPE lty_ordi.

SELECTION-SCREEN BEGIN OF BLOCK bc1 WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_ono FOR lv_ono.
SELECTION-SCREEN END OF BLOCK bc1.

START-OF-SELECTION.

  SELECT ono odate pm ta curr
    FROM zordh_28
    INTO TABLE lt_ordh
    WHERE ono IN s_ono.

  DESCRIBE TABLE lt_ordh LINES lv_lines.

*Hide Statment
*
*  LOOP AT lt_ordh INTO lwa_ordh.
*    WRITE: / lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-pm, lwa_ordh-ta, lwa_ordh-curr.
*    HIDE: lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-pm, lwa_ordh-ta, lwa_ordh-curr.
*  ENDLOOP.

  WRITE: / TEXT-006, lv_lines COLOR COL_POSITIVE.

  WRITE: / sy-uline(72).
  WRITE: / sy-vline, TEXT-001,
           16 sy-vline, TEXT-002,
           30 sy-vline, TEXT-003,
           45 sy-vline, TEXT-004,
           60 sy-vline, TEXT-005, 72 sy-vline.

  WRITE: / sy-uline(72).

  IF lt_ordh IS NOT INITIAL.
    LOOP AT lt_ordh INTO lwa_ordh.
      WRITE: / sy-vline, lwa_ordh-ono UNDER TEXT-001,
              16 sy-vline, lwa_ordh-odate UNDER TEXT-002,
              30 sy-vline, lwa_ordh-pm UNDER TEXT-003,
              45 sy-vline, lwa_ordh-ta UNDER TEXT-004,
              60 sy-vline, lwa_ordh-curr UNDER TEXT-005, 72 sy-vline.
      HIDE: lwa_ordh-ono, lwa_ordh-odate, lwa_ordh-pm, lwa_ordh-ta, lwa_ordh-curr. " To store Records data into the hide Area after the Write Statment
      WRITE: / sy-uline(72).
    ENDLOOP.
  ELSE.
    MESSAGE: i001(zmessage) WITH s_ono-low.
  ENDIF.

AT LINE-SELECTION.

*  SELECT ono oin odesc icost
*    FROM zordi_28
*    INTO TABLE lt_ordi
*    WHERE ono = sy-lisel+2(12).  " Substring from System Variable sy-lisel, it contains the Data of the selected Record Line.


  SELECT ono oin odesc icost
  FROM zordi_28
  INTO TABLE lt_ordi
  WHERE ono = lwa_ordh-ono.

  DESCRIBE TABLE lt_ordi LINES lv_lines1.

  WRITE: / TEXT-006, lv_lines1 COLOR COL_POSITIVE.

  WRITE: / sy-uline(85).
  WRITE: / sy-vline, TEXT-001,
           16 sy-vline, TEXT-007,
           38 sy-vline, TEXT-008,
           68 sy-vline, TEXT-009, 85 sy-vline.

  WRITE: / sy-uline(85).

  LOOP AT lt_ordi INTO lwa_ordi.
    WRITE: / sy-vline, lwa_ordi-ono UNDER TEXT-001,
             16 sy-vline, lwa_ordi-oin UNDER TEXT-007,
             38 sy-vline, lwa_ordi-odesc UNDER TEXT-008,
             68 sy-vline, lwa_ordi-icost UNDER TEXT-009, 85 sy-vline.

    WRITE: / sy-uline(85).
  ENDLOOP.
