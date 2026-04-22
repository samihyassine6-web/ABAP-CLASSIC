*&---------------------------------------------------------------------*
*& Report ZPRG_SO_JOIN_ORDH_ORDI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_so_join_ordh_ordi.

DATA: lv_ono TYPE zdeono_28.

* Range Selection Join
*---------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_ono FOR lv_ono.
SELECTION-SCREEN END OF BLOCK b1.

*TYPES: BEGIN OF lty_ordh_28,
*         ono   TYPE zdeono_28,
*         odate TYPE zdeodate_28,
*         pm    TYPE zdepm_28,
*         ta    TYPE zdeta_28,
*         curr  TYPE zdecurr_28,
*       END OF lty_ordh_28.
*
*DATA: lt_ordh_28 TYPE TABLE OF lty_ordh_28.
*DATA: lwa_ordh_28 TYPE  lty_ordh_28.
*
*TYPES: BEGIN OF lty_ordi_28,
*         ono   TYPE zdeono_28,
*         oin   TYPE zdeoin_28,
*         odesc TYPE zdeodesc_28,
*         icost TYPE zdeicost_28,
*       END OF lty_ordi_28.
*
*DATA: lt_ordi_28 TYPE TABLE OF lty_ordi_28.
*DATA: lwa_ordi_28 TYPE  lty_ordi_28.


TYPES: BEGIN OF lty_final,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         pm    TYPE zdepm_28,
         ta    TYPE zdeta_28,
         curr  TYPE zdecurr_28,
         oin   TYPE zdeoin_28,
         odesc TYPE zdeodesc_28,
         icost TYPE zdeicost_28,
       END OF lty_final.

DATA: lt_final TYPE TABLE OF lty_final.
DATA: lwa_final TYPE lty_final.
*DATA: lv_flag TYPE boolean.

* INNER JOIN = JOIN-> ONLY MATCHING DATA PREFERED ON HANA DATABASE
*-------------------------------------------------------------*

*SELECT a~ono a~odate a~pm a~ta a~curr b~oin b~odesc b~icost
*  FROM zordh_28 AS a JOIN zordi_28 AS b
*  ON a~ono = b~ono
*  INTO TABLE lt_final
*  WHERE a~ono IN s_ono.

* LEFT OUTER JOIN = OUTER JOIN-> MATCHING AND NO MATCHING DATA
*-------------------------------------------------------------*

  SELECT a~ono a~odate a~pm a~ta a~curr b~oin b~odesc b~icost
  FROM zordh_28 AS a LEFT OUTER JOIN zordi_28 AS b
  ON a~ono = b~ono
  INTO TABLE lt_final
  WHERE a~ono IN s_ono.




* FOR ALL ENTRIES IN
*----------------------------------*
*SELECT ono odate pm ta curr
*  FROM zordh_28
*  INTO TABLE lt_ordh_28
*  WHERE ono IN s_ono.
*
*IF lt_ordh_28 IS NOT INITIAL.
*  SELECT ono oin odesc icost
*    FROM zordi_28
*    INTO TABLE lt_ordi_28
*    FOR ALL ENTRIES IN lt_ordh_28
*    WHERE ono = lt_ordh_28-ono.
*ENDIF.
*
*LOOP AT lt_ordh_28 INTO lwa_ordh_28.
*
*  LOOP AT lt_ordi_28 INTO lwa_ordi_28 WHERE ono = lwa_ordh_28-ono.
*    lwa_final-ono   = lwa_ordh_28-ono.
*    lwa_final-odate = lwa_ordh_28-odate.
*    lwa_final-pm = lwa_ordh_28-pm.
*    lwa_final-ta    = lwa_ordh_28-ta.
*    lwa_final-curr  = lwa_ordh_28-curr.
*    lwa_final-oin   = lwa_ordi_28-oin.
*    lwa_final-odesc = lwa_ordi_28-odesc.
*    lwa_final-icost = lwa_ordi_28-icost.
*    APPEND lwa_final TO lt_final.
*    CLEAR: lwa_final.
*    lv_flag = 'X'.
*  ENDLOOP.
*  IF lv_flag = ' '.
*    lwa_final-ono   = lwa_ordh_28-ono.
*    lwa_final-odate = lwa_ordh_28-odate.
*    lwa_final-pm = lwa_ordh_28-pm.
*    lwa_final-ta    = lwa_ordh_28-ta.
*    lwa_final-curr  = lwa_ordh_28-curr.
*    APPEND lwa_final TO lt_final.
*    CLEAR: lwa_final.
*  ENDIF.
*  CLEAR: lv_flag.
*ENDLOOP.

*LOOP AT lt_final INTO lwa_final.
*  WRITE: / lwa_final-ono, lwa_final-odate, lwa_final-pm, lwa_final-ta, lwa_final-curr,
*           lwa_final-oin, lwa_final-odesc, lwa_final-icost.
*ENDLOOP.

cl_demo_output=>display( lt_final ).
