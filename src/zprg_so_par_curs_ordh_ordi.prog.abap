*&---------------------------------------------------------------------*
*& Report ZPRG_SO_PAR_CURS_ORDH_ORDI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_so_par_curs_ordh_ordi.

DATA: lv_ono TYPE zdeono_28.

* Paralel Cursor improving the Performence and Slection of also not mathed Records
*-----------------------------------------------------------------------------------*

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

TYPES: BEGIN OF lty_ordi_28,
         ono   TYPE zdeono_28,
         oin   TYPE zdeoin_28,
         odesc TYPE zdeodesc_28,
         icost TYPE zdeicost_28,
       END OF lty_ordi_28.

DATA: lt_ordi_28 TYPE TABLE OF lty_ordi_28.
DATA: lwa_ordi_28 TYPE  lty_ordi_28.


TYPES: BEGIN OF lty_final,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         ta    TYPE zdeta_28,
         curr  TYPE zdecurr_28,
         oin   TYPE zdeoin_28,
         odesc TYPE zdeodesc_28,
         icost TYPE zdeicost_28,
       END OF lty_final.

DATA: lt_final TYPE TABLE OF lty_final.
DATA: lwa_final TYPE lty_final.
DATA: lv_flag TYPE boolean.
DATA: lv_flag1 TYPE boolean.
DATA: lv_index TYPE i.
DATA: lv_final TYPE i.



SELECT ono odate ta curr
  FROM zordh_28
  INTO TABLE lt_ordh_28
  WHERE ono IN s_ono.

IF lt_ordh_28 IS NOT INITIAL.
  SELECT ono oin odesc icost
    FROM zordi_28
    INTO TABLE lt_ordi_28
    FOR ALL ENTRIES IN lt_ordh_28
    WHERE ono = lt_ordh_28-ono.
ELSE.
  MESSAGE: i001(zmessage) WITH s_ono-low.
  lv_flag1 = 'X'.
ENDIF.

IF lv_flag1 = ' '.

  SORT lt_ordi_28 BY ono.

  LOOP AT lt_ordh_28 INTO lwa_ordh_28.
    READ TABLE lt_ordi_28 INTO lwa_ordi_28 WITH KEY ono = lwa_ordh_28-ono BINARY SEARCH.
    IF sy-subrc = 0.
      lv_index = sy-tabix.
    ENDIF.
    LOOP AT lt_ordi_28 INTO lwa_ordi_28 FROM lv_index.       "WHERE ono = lwa_ordh_28-ono.
      IF lwa_ordh_28-ono <> lwa_ordi_28-ono.
        EXIT.
      ELSE.
        lwa_final-ono   = lwa_ordh_28-ono.
        lwa_final-odate = lwa_ordh_28-odate.
        lwa_final-ta    = lwa_ordh_28-ta.
        lwa_final-curr  = lwa_ordh_28-curr.
        lwa_final-oin   = lwa_ordi_28-oin.
        lwa_final-odesc = lwa_ordi_28-odesc.
        lwa_final-icost = lwa_ordi_28-icost.
        APPEND lwa_final TO lt_final.
        CLEAR: lwa_final.
      ENDIF.
      lv_flag = 'X'.
    ENDLOOP.
    IF lv_flag = ' '.
      lwa_final-ono   = lwa_ordh_28-ono.
      lwa_final-odate = lwa_ordh_28-odate.
      lwa_final-ta    = lwa_ordh_28-ta.
      lwa_final-curr  = lwa_ordh_28-curr.
      APPEND lwa_final TO lt_final.
      CLEAR: lwa_final.
    ENDIF.
    CLEAR: lv_flag.
  ENDLOOP.

  DESCRIBE TABLE lt_final LINES lv_final.
  WRITE:  / TEXT-008, lv_final.
  ULINE.
*To Add horisontal and vertical Lines
*--------------------------------------*
  WRITE: sy-uline(112).
  WRITE: / sy-vline, TEXT-001,
           16 sy-vline, TEXT-002,
           30 sy-vline, TEXT-003,
           45 sy-vline, TEXT-004,
           55 sy-vline, TEXT-005,
           72 sy-vline, TEXT-006,
           98 sy-vline, TEXT-007, 112 sy-vline. " Field Labels

  WRITE: / sy-uline(112).

  LOOP AT lt_final INTO lwa_final.
    WRITE: / sy-vline, lwa_final-ono      UNDER TEXT-001,
             16 sy-vline, lwa_final-odate UNDER TEXT-002,
             30 sy-vline, lwa_final-ta    UNDER TEXT-003 ,
             45 sy-vline, lwa_final-curr  UNDER TEXT-004,
             55 sy-vline, lwa_final-oin   UNDER TEXT-005 ,
             72 sy-vline, lwa_final-odesc UNDER TEXT-006,
             98 sy-vline, lwa_final-icost UNDER TEXT-007, 112 sy-vline.
    WRITE: / sy-uline(112).
  ENDLOOP.


ENDIF.
