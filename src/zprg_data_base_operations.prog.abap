*&---------------------------------------------------------------------*
*& Report ZPRG_DATA_BASE_OPERATIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_data_base_operations.

TABLES: zordh_28.

DATA: lt_ordh TYPE TABLE OF zordh_28.
DATA: lwa_ordh TYPE zordh_28.
DATA: lv_lines TYPE i.

TYPES: BEGIN OF lty_display,
         odate  TYPE zdeodate_28,
         creaby TYPE zdecrby_28,
         dno    TYPE zdedn_28,
         ddate  TYPE zdeddate_28,
         pm     TYPE zdepm_28,
         ta     TYPE zdeta_28,
         curr   TYPE zdecurr_28,
         dloc   TYPE zdedloc_28,
       END OF lty_display.

DATA: lwa_display TYPE lty_display.

*TYPES: BEGIN OF lty_ordh,
*         mandt TYPE mandt,   " obligatorisch
*         ono   TYPE zdeono_28,
*         odate TYPE zdeodate_28,
*         dno   TYPE zdedn_28,
*         ddate TYPE zdeddate_28,
*         pm    TYPE zdepm_28,
*         ta    TYPE zdeta_28,
*         curr  TYPE zdecurr_28,
*         dloc  TYPE zdedloc_28,
*       END OF lty_ordh.
*
*DATA: lt_ordh TYPE TABLE OF lty_ordh.
*DATA: lwa_ordh TYPE lty_ordh.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
PARAMETERS: p_mandt TYPE mandt MODIF ID m1 DEFAULT sy-mandt.
PARAMETERS: p_ono   TYPE zordh_28-ono OBLIGATORY.
PARAMETERS: p_odate TYPE zdeodate_28 MODIF ID m2.
PARAMETERS: p_creaby TYPE zdecrby_28 MODIF ID m2.
PARAMETERS: p_dno   TYPE zdedn_28 MODIF ID m3.
PARAMETERS: p_ddate TYPE zdeddate_28 MODIF ID m3.
PARAMETERS: p_pm    TYPE zdepm_28 MODIF ID m5.
PARAMETERS: p_ta    TYPE zdeta_28 MODIF ID m6.
PARAMETERS: p_curr  TYPE zdecurr_28 MODIF ID m7.
PARAMETERS: p_dloc  TYPE zdedloc_28 MODIF ID m8.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_r1 RADIOBUTTON GROUP gr1 USER-COMMAND click DEFAULT 'X'.
PARAMETERS: p_r2 RADIOBUTTON GROUP gr1.
PARAMETERS: p_r3 RADIOBUTTON GROUP gr1.
PARAMETERS: p_r4 RADIOBUTTON GROUP gr1 .
SELECTION-SCREEN END OF BLOCK b2.

INITIALIZATION.

  SELECT ono FROM zordh_28 INTO TABLE lt_ordh.
  DESCRIBE TABLE lt_ordh LINES lv_lines.
  p_ono   = lv_lines.
  p_odate = sy-datum.
  p_creaby = sy-uname.
  p_ddate = sy-datum + 15.
  p_curr  = 'MAD'.


AT SELECTION-SCREEN.

*  IF p_curr <> 'USD' AND p_curr <> 'MAD' AND p_curr <> 'EUR'.
*    MESSAGE: e003(zmessage).
*  ENDIF.

  IF p_r1 = 'X'.
    SELECT SINGLE ono FROM zordh_28 INTO lwa_ordh WHERE ono = p_ono.
    IF lwa_ordh IS NOT INITIAL.
      MESSAGE: e005(zmessage) WITH p_ono.
    ENDIF.
  ENDIF.

  IF p_r2 = 'X'.
    SELECT SINGLE * FROM zordh_28 INTO lwa_ordh
      WHERE ono = p_ono.
    IF sy-subrc <> 0.
      MESSAGE: e006(zmessage) WITH p_ono.
    ENDIF.
  ENDIF.

  IF p_r3 = 'X'.
    SELECT SINGLE * FROM zordh_28 INTO lwa_ordh
      WHERE ono = p_ono.
    IF sy-subrc <> 0.
      MESSAGE: e006(zmessage) WITH p_ono.
    ELSE.
      SELECT SINGLE odate creaby dno ddate pm ta curr dloc
        FROM zordh_28
        INTO lwa_display
        WHERE ono = p_ono.
    ENDIF.
  ENDIF.

  IF p_r4 = 'X'.
    SELECT SINGLE odate creaby dno ddate pm ta curr dloc
     FROM zordh_28
     INTO lwa_display
     WHERE ono = p_ono.
    IF sy-subrc <> 0.
      CLEAR: lwa_display.
    ENDIF.

  ENDIF.


AT SELECTION-SCREEN OUTPUT.

  IF p_r2 = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'M1' OR screen-group1 = 'M2' OR screen-group1 = 'M3' OR screen-group1 = 'M4'
        OR screen-group1 = 'M5' OR screen-group1 = 'M6' OR screen-group1 = 'M7' OR screen-group1 = 'M8'.
        screen-input = 0.
        MODIFY SCREEN. " always modify the screen
      ENDIF.
    ENDLOOP.

  ENDIF.

  IF p_r3 = 'X'.
    p_odate  = lwa_display-odate.
    p_creaby  = lwa_display-creaby.
    p_dno    = lwa_display-dno.
    p_ddate  = lwa_display-ddate.
    p_pm     = lwa_display-pm.
    p_ta     = lwa_display-ta.
    p_curr   = lwa_display-curr.
    p_dloc   = lwa_display-dloc.
  ENDIF.

  IF p_r4 = 'X'.
    p_odate  = lwa_display-odate.
    p_creaby  = lwa_display-creaby.
    p_dno    = lwa_display-dno.
    p_ddate  = lwa_display-ddate.
    p_pm     = lwa_display-pm.
    p_ta     = lwa_display-ta.
    p_curr   = lwa_display-curr.
    p_dloc   = lwa_display-dloc.
  ENDIF.

START-OF-SELECTION.

* INSERT
*-------------------------------------------------------*

  IF p_r1 = 'X'.
    lwa_ordh-ono   = p_ono.
    lwa_ordh-odate = p_odate.
    lwa_ordh-creaby = p_creaby.
    lwa_ordh-dno   = p_dno.
    lwa_ordh-ddate = p_ddate.
    lwa_ordh-pm    = p_pm.
    lwa_ordh-ta    = p_ta.
    lwa_ordh-curr  = p_curr.
    lwa_ordh-dloc  = p_dloc.
    INSERT zordh_28 FROM lwa_ordh.
    IF sy-subrc = 0.
      MESSAGE: s004(zmessage) WITH lwa_ordh-ono.
    ENDIF.
  ENDIF.

* DELETE
*-------------------------------------------------------*

  IF p_r2 = 'X'.
    lwa_ordh-ono = p_ono.
    DELETE zordh_28 FROM lwa_ordh.
    MESSAGE: s007(zmessage) WITH lwa_ordh-ono.
  ENDIF.

* UPDATE
*-------------------------------------------------------*

  IF p_r3 = 'X'.
    lwa_ordh-odate = p_odate.
    lwa_ordh-creaby = p_creaby.
    lwa_ordh-dno   = p_dno.
    lwa_ordh-ddate = p_ddate.
    lwa_ordh-pm    = p_pm.
    lwa_ordh-ta    = p_ta.
    lwa_ordh-curr  = p_curr.
    lwa_ordh-dloc  = p_dloc.
    UPDATE: zordh_28 FROM lwa_ordh.
    IF sy-subrc = 0.
      MESSAGE: s008(zmessage) WITH p_ono.
    ENDIF.
  ENDIF.

*  MODIFY
*--------------------------------------------------------*

  IF p_r4 = 'X'.
    lwa_ordh-ono   = p_ono.
    lwa_ordh-odate = p_odate.
    lwa_ordh-creaby = p_creaby.
    lwa_ordh-dno   = p_dno.
    lwa_ordh-ddate = p_ddate.
    lwa_ordh-pm    = p_pm.
    lwa_ordh-ta    = p_ta.
    lwa_ordh-curr  = p_curr.
    lwa_ordh-dloc  = p_dloc.
    MODIFY zordh_28 FROM lwa_ordh.
    IF sy-subrc = 0.
      MESSAGE: s009(zmessage) WITH p_ono.
    ENDIF.
  ENDIF.
