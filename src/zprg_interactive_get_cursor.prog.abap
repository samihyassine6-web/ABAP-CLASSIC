*&---------------------------------------------------------------------*
*& Report ZPRG_INTERACTIVE_GET_CURSOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_interactive_get_cursor.

DATA: lv_ono TYPE zdeono_28.
DATA: lv_lines TYPE i.
DATA: lv_lines1 TYPE i.
DATA: lv_lines2 TYPE i.
DATA: lv_field(30) TYPE c.
DATA: lv_value(30) TYPE c.


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

TYPES: BEGIN OF lty_data,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         oin   TYPE zdeoin_28,
         dno   TYPE zdedn_28,
         odesc TYPE zdeodesc_28,
         ta    TYPE zdeta_28,
         curr  TYPE zdecurr_28,
         ddate TYPE zdeddate_28,
         dloc  TYPE zdedloc_28,
       END OF lty_data.

DATA: lt_data TYPE TABLE OF lty_data.
DATA: lwa_data TYPE lty_data.

TYPES: BEGIN OF lty_data1,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         dno   TYPE zdedn_28,
         ddate TYPE zdeddate_28,
         ta    TYPE zdeta_28,
         curr  TYPE zdecurr_28,
         dloc  TYPE zdedloc_28,
       END OF lty_data1.

DATA: lt_data1 TYPE TABLE OF lty_data1.
DATA: lwa_data1 TYPE lty_data1.

TYPES: BEGIN OF lty_data2,
         ono   TYPE zdeono_28,
         oin   TYPE zdeoin_28,
         odesc TYPE zdeodesc_28,
       END OF lty_data2.

DATA: lt_data2 TYPE TABLE OF lty_data2.
DATA: lwa_data2 TYPE lty_data2.

SELECTION-SCREEN BEGIN OF BLOCK bc1 WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_ono FOR lv_ono.
SELECTION-SCREEN END OF BLOCK bc1.

START-OF-SELECTION.

  SELECT ono odate pm ta curr
    FROM zordh_28
    INTO TABLE lt_ordh
    WHERE ono IN s_ono.

  DESCRIBE TABLE lt_ordh LINES lv_lines.

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
      WRITE: / sy-uline(72).
    ENDLOOP.
  ELSE.
    MESSAGE: i001(zmessage) WITH s_ono-low.
  ENDIF.


  SET PF-STATUS 'FUNCTION'.


AT USER-COMMAND.
  IF sy-ucomm = 'ASCENDING'.
    SORT: lt_ordh BY ono.

    DESCRIBE TABLE lt_ordh LINES lv_lines.

    WRITE: / TEXT-006, lv_lines COLOR COL_POSITIVE.

    WRITE: / sy-uline(72).
    WRITE: / sy-vline, TEXT-001,
             16 sy-vline, TEXT-002,
             30 sy-vline, TEXT-003,
             45 sy-vline, TEXT-004,
             60 sy-vline, TEXT-005, 72 sy-vline.

    WRITE: / sy-uline(72).
    LOOP AT lt_ordh INTO lwa_ordh.
      WRITE: / sy-vline, lwa_ordh-ono UNDER TEXT-001,
              16 sy-vline, lwa_ordh-odate UNDER TEXT-002,
              30 sy-vline, lwa_ordh-pm UNDER TEXT-003,
              45 sy-vline, lwa_ordh-ta UNDER TEXT-004,
              60 sy-vline, lwa_ordh-curr UNDER TEXT-005, 72 sy-vline.
      WRITE: / sy-uline(72).
    ENDLOOP.
  ENDIF.

  IF sy-ucomm = 'DESCENDING'.
    SORT: lt_ordh BY ono DESCENDING.

    DESCRIBE TABLE lt_ordh LINES lv_lines.

    WRITE: / TEXT-006, lv_lines COLOR COL_POSITIVE.

    WRITE: / sy-uline(72).
    WRITE: / sy-vline, TEXT-001,
             16 sy-vline, TEXT-002,
             30 sy-vline, TEXT-003,
             45 sy-vline, TEXT-004,
             60 sy-vline, TEXT-005, 72 sy-vline.

    WRITE: / sy-uline(72).
    LOOP AT lt_ordh INTO lwa_ordh.
      WRITE: / sy-vline, lwa_ordh-ono UNDER TEXT-001,
              16 sy-vline, lwa_ordh-odate UNDER TEXT-002,
              30 sy-vline, lwa_ordh-pm UNDER TEXT-003,
              45 sy-vline, lwa_ordh-ta UNDER TEXT-004,
              60 sy-vline, lwa_ordh-curr UNDER TEXT-005, 72 sy-vline.
      WRITE: / sy-uline(72).
    ENDLOOP.
  ENDIF.

* AT LINE-SELECTION Interacction with the basic List
*----------------------------------------------------------------------------*

*    AT LINE-SELECTION.




  IF sy-ucomm = 'ENTER'.

 GET CURSOR FIELD lv_field VALUE lv_value.

    IF lv_field = 'LWA_ORDH-ONO'.
      SELECT ono oin odesc icost
      FROM zordi_28
      INTO TABLE lt_ordi
      WHERE ono = lv_value.

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
    ENDIF.

    IF lv_field = 'LWA_ORDH-ODATE'.

      DATA: lv_datum TYPE sy-datum.
      DATA: lv_value1(2) TYPE c.
      DATA: lv_value2(2) TYPE c.
      DATA: lv_value3(4) TYPE c.
      DATA: lv_flag TYPE boolean.

      SPLIT: lv_value AT '.' INTO lv_value1 lv_value2 lv_value3.
      CONCATENATE lv_value3 lv_value2 lv_value1 INTO lv_datum.

      SELECT ono odate dno ddate ta curr dloc
        FROM zordh_28
        INTO TABLE lt_data1
      WHERE odate = lv_datum.

      SELECT ono oin odesc
        FROM zordi_28
        INTO TABLE lt_data2
        FOR ALL ENTRIES IN lt_data1
      WHERE ono = lt_data1-ono.

      LOOP AT lt_data1 INTO lwa_data1.
        LOOP AT lt_data2 INTO lwa_data2 WHERE ono = lwa_data1-ono.
          lwa_data-ono   = lwa_data1-ono.
          lwa_data-odate = lwa_data1-odate.
          lwa_data-oin   = lwa_data2-oin.
          lwa_data-dno   = lwa_data1-dno.
          lwa_data-odesc = lwa_data2-odesc.
          lwa_data-ta    = lwa_data1-ta.
          lwa_data-curr  = lwa_data1-curr.
          lwa_data-ddate = lwa_data1-ddate.
          lwa_data-dloc  = lwa_data1-dloc.
          APPEND: lwa_data TO lt_data.
          CLEAR: lwa_data.
          lv_flag = 'X'.
        ENDLOOP.
        IF lv_flag = ' '.
          lwa_data-ono   = lwa_data1-ono.
          lwa_data-odate = lwa_data1-odate.
          lwa_data-dno   = lwa_data1-dno.
          lwa_data-ta    = lwa_data1-ta.
          lwa_data-curr  = lwa_data1-curr.
          lwa_data-ddate = lwa_data1-ddate.
          lwa_data-dloc  = lwa_data1-dloc.
          APPEND: lwa_data TO lt_data.
          CLEAR: lwa_data.
          CLEAR: lv_flag.
        ENDIF.
      ENDLOOP.

      DESCRIBE TABLE lt_data LINES lv_lines2.

      WRITE: / TEXT-006, lv_lines2 COLOR COL_POSITIVE.

      WRITE: / sy-uline(180).
      WRITE: / sy-vline, TEXT-001,
               16 sy-vline, TEXT-002,
               32 sy-vline, TEXT-010,  "oin
               56 sy-vline, TEXT-011,  "dno
               76 sy-vline, TEXT-008,
               110 sy-vline, TEXT-004,
               125 sy-vline, TEXT-005,
               140 sy-vline, TEXT-012,
               155 sy-vline, TEXT-013, 180 sy-vline.
      WRITE: / sy-uline(180).

      LOOP AT lt_data INTO lwa_data.
        WRITE: / sy-vline, lwa_data-ono UNDER TEXT-001,
                 16 sy-vline,  lwa_data-odate UNDER TEXT-002,
                 32 sy-vline,  lwa_data-oin UNDER TEXT-010,
                 56 sy-vline,  lwa_data-dno UNDER TEXT-011,
                 76 sy-vline,  lwa_data-odesc UNDER TEXT-008,
                 110 sy-vline, lwa_data-ta UNDER TEXT-004,
                 125 sy-vline, lwa_data-curr UNDER TEXT-005,
                 140 sy-vline, lwa_data-ddate UNDER TEXT-012,
                 155 sy-vline, lwa_data-dloc UNDER TEXT-013, 180 sy-vline.
        WRITE: / sy-uline(180).
      ENDLOOP.
      CLEAR: lt_data.
    ENDIF.
  ENDIF.
