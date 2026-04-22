*&---------------------------------------------------------------------*
*& Report ZPRG_CLASS_REPORT_EVENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_class_report_events LINE-COUNT 30(2). " To Display Records in multiple Pages, (2) Lines reserved for END-OF-PAGE.

DATA: lv_odate TYPE zdeodate_28.
DATA: lv_pm TYPE zdepm_28.
DATA: lv_curr TYPE zdecurr_28.
DATA: lv_lines TYPE i.

TYPES: BEGIN OF lty_ordh,
         ono   TYPE zdeono_28,
         odate TYPE zdeodate_28,
         pm    TYPE zdepm_28,
         curr  TYPE zdecurr_28,
       END OF lty_ordh.

DATA: lt_ordh TYPE TABLE OF lty_ordh.
DATA: lwa_ordh TYPE lty_ordh.

TYPES: BEGIN OF lty_pm,
         pm   TYPE zdepm_28,
         desc TYPE zdesc40,
       END OF lty_pm.

DATA: lt_pm TYPE TABLE OF lty_pm.
DATA: lwa_pm TYPE lty_pm.

TYPES: BEGIN OF lty_curr,
         curr TYPE zdecurr_28,
         desc TYPE zdesc40,
       END OF lty_curr.

DATA: lt_curr TYPE TABLE OF lty_curr.
DATA: lwa_curr TYPE lty_curr.

DATA: lt_links TYPE TABLE OF tline.


SELECTION-SCREEN BEGIN OF BLOCK bc1 WITH FRAME TITLE TEXT-000.
SELECT-OPTIONS: s_odate FOR lv_odate NO-EXTENSION.
SELECT-OPTIONS: s_pm FOR lv_pm NO INTERVALS.
SELECTION-SCREEN END OF BLOCK bc1.
SELECTION-SCREEN BEGIN OF BLOCK bc2 WITH FRAME TITLE TEXT-009.
SELECT-OPTIONS: s_curr FOR lv_curr NO INTERVALS MODIF ID cur.
PARAMETERS: p_chk AS CHECKBOX USER-COMMAND selection.
SELECTION-SCREEN END OF BLOCK bc2.

*-----------------------------------------------------------------------------*
* To assign the default initial Values befor Calling the Selection Screen ONE TIME.
*-----------------------------------------------------------------------------*

INITIALIZATION.

  s_odate-sign    = 'I'.
  s_odate-option  = 'BT'.
  s_odate-low     = sy-datum  - 100.
  s_odate-high    = sy-datum.
  APPEND s_odate.

*-----------------------------------------------------------------------------*
* AT SELECTION-SCREEN ON VALUE-REQUEST FOR FIELD F4 HELP
*-----------------------------------------------------------------------------*

AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_pm-low.

  lwa_pm-pm = 'C'.
  lwa_pm-desc = TEXT-010.
  APPEND lwa_pm TO lt_pm.
  CLEAR:lwa_pm.

  lwa_pm-pm = 'D'.
  lwa_pm-desc = TEXT-011.
  APPEND lwa_pm TO lt_pm.
  CLEAR:lwa_pm.

  lwa_pm-pm = 'N'.
  lwa_pm-desc = TEXT-012.
  APPEND lwa_pm TO lt_pm.
  CLEAR:lwa_pm.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
*     DDIC_STRUCTURE  = ' '
      retfield        = 'PM'
*     PVALKEY         = ' '
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = 'S_PM_LOW '
*     STEPL           = 0
*     WINDOW_TITLE    =
*     VALUE           = ' '
      value_org       = 'S'
*     MULTIPLE_CHOICE = ' '
*     DISPLAY         = ' '
*     CALLBACK_PROGRAM       = ' '
*     CALLBACK_FORM   = ' '
*     CALLBACK_METHOD =
*     MARK_TAB        =
*  IMPORTING
*     USER_RESET      =
    TABLES
      value_tab       = lt_pm
*     FIELD_TAB       =
*     RETURN_TAB      =
*     DYNPFLD_MAPPING =
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
  CLEAR: lt_pm.


AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_curr-low.

  lwa_curr-curr = 'EUR'.
  lwa_curr-desc = TEXT-013.
  APPEND lwa_curr TO lt_curr.
  CLEAR:lwa_curr.

  lwa_curr-curr = 'MAD'.
  lwa_curr-desc = TEXT-014.
  APPEND lwa_curr TO lt_curr.
  CLEAR:lwa_curr.

  lwa_curr-curr = 'USD'.
  lwa_curr-desc = TEXT-015.
  APPEND lwa_curr TO lt_curr.
  CLEAR:lwa_curr.


  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
*     DDIC_STRUCTURE  = ' '
      retfield        = 'CURR'
*     PVALKEY         = ' '
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = 'S_CURR_LOW '
*     STEPL           = 0
*     WINDOW_TITLE    =
*     VALUE           = ' '
      value_org       = 'S'
*     MULTIPLE_CHOICE = ' '
*     DISPLAY         = ' '
*     CALLBACK_PROGRAM       = ' '
*     CALLBACK_FORM   = ' '
*     CALLBACK_METHOD =
*     MARK_TAB        =
*  IMPORTING
*     USER_RESET      =
    TABLES
      value_tab       = lt_curr
*     FIELD_TAB       =
*     RETURN_TAB      =
*     DYNPFLD_MAPPING =
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
  CLEAR: lt_curr.

*-----------------------------------------------------------------------------*
* AT SELECTION-SCREEN ON HELP-REQUEST FOR FIELD F1 HELP
*-----------------------------------------------------------------------------*

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_chk.

  CALL FUNCTION 'HELP_OBJECT_SHOW'
    EXPORTING
      dokclass         = 'TX'
*     DOKLANGU         = SY-LANGU
      dokname          = 'ZDOCCUR'
*     DOKTITLE         = ' '
*     CALLED_BY_PROGRAM                   = ' '
*     CALLED_BY_DYNP   = ' '
*     CALLED_FOR_TAB   = ' '
*     CALLED_FOR_FIELD = ' '
*     CALLED_FOR_TAB_FLD_BTCH_INPUT       = ' '
*     MSG_VAR_1        = ' '
*     MSG_VAR_2        = ' '
*     MSG_VAR_3        = ' '
*     MSG_VAR_4        = ' '
*     CALLED_BY_CUAPROG                   = ' '
*     CALLED_BY_CUASTAT                   =
*     SHORT_TEXT       = ' '
*     CLASSIC_SAPSCRIPT                   = ' '
*     MES_PROGRAM_NAME = ' '
*     MES_INCLUDE_NAME = ' '
*     MES_LINE_NUMBER  =
*     MES_EXCEPTION    = ' '
    TABLES
      links            = lt_links
    EXCEPTIONS
      object_not_found = 1
      sapscript_error  = 2
      OTHERS           = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


*-----------------------------------------------------------------------------*
* To Modify the Selection Screen AT SELECTION-SCREEN OUTPUT-> PBO
*-----------------------------------------------------------------------------*

AT SELECTION-SCREEN OUTPUT.

  IF p_chk = ' '.
    LOOP AT SCREEN.
      IF screen-group1 = 'CUR'.  " based upon MODIIF ID
        screen-active  = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF p_chk = 'X'.
    LOOP AT SCREEN.
      IF screen-group1 = 'CUR'.  " based upon MODIIF ID
        screen-active  = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

* based upon individual Screen Names

*  IF p_chk = ' '.
*    LOOP AT SCREEN.
*      IF screen-name = '%_S_CURR_%_APP_%-TEXT' OR screen-name = 'S_CURR-LOW' OR screen-name = '%_S_CURR_%_APP_%-VALU_PUSH'.
*        screen-active = 0.
*        MODIFY SCREEN.
*      ENDIF.
*    ENDLOOP.
*  ENDIF.

*-----------------------------------------------------------------------------*
* Check Validation AT SELECTION-SCREEN INPUT SCREEN
*-----------------------------------------------------------------------------*

*AT SELECTION-SCREEN ON s_pm.  " To validat specified Fields, other fields will be disabled
*  IF s_pm-low IS NOT INITIAL.
*    IF s_pm-low <> 'C' AND s_pm-low <> 'D' AND s_pm-low <> 'N'.
*      MESSAGE: e002(zmessage).
*    ENDIF.
*  ENDIF.
*
*AT SELECTION-SCREEN ON s_curr.
*
*  IF s_curr-low IS NOT INITIAL.
*    IF s_curr-low <> 'MAD' OR s_curr-low <> 'EUR'.
*      MESSAGE: e003(zmessage).
*      CLEAR: s_curr-low.
*    ENDIF.
*  ENDIF.


AT SELECTION-SCREEN.

  IF s_pm-low IS NOT INITIAL.
    IF s_pm-low <> 'C' AND s_pm-low <> 'D' AND s_pm-low <> 'N'.
      SET CURSOR FIELD 'S_PM_LOW'.  " highlighting field
      MESSAGE: e002(zmessage).
    ENDIF.
  ENDIF.

  IF s_curr-low IS NOT INITIAL.
    IF s_curr-low <> 'MAD' OR s_curr-low <> 'EUR'.
      SET CURSOR FIELD 'S_CURR_LOW'.
      MESSAGE: e003(zmessage).
    ENDIF.
  ENDIF.

*------------------------------------------------------------------------------*
* Execution START-OF-SELECTION F8-> Execute Click
*------------------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT ono odate pm curr
    FROM zordh_28
    INTO TABLE lt_ordh
    WHERE odate IN s_odate
    AND pm      IN s_pm
    AND curr    IN s_curr.

  DESCRIBE TABLE lt_ordh LINES lv_lines.

  WRITE: sy-uline(55).
  WRITE: / sy-vline, TEXT-001,
           16 sy-vline, TEXT-002,
           30 sy-vline, TEXT-003,
           45 sy-vline, TEXT-004, 55 sy-vline.
  WRITE: / sy-uline(55).

  LOOP AT lt_ordh INTO lwa_ordh.
    WRITE: / sy-vline, lwa_ordh-ono UNDER TEXT-001,
             16 sy-vline, lwa_ordh-odate UNDER TEXT-002,
             30 sy-vline, lwa_ordh-pm UNDER TEXT-003,
             45 sy-vline, lwa_ordh-curr UNDER TEXT-004, 55 sy-vline.
    WRITE: / sy-uline(55).
  ENDLOOP.

END-OF-SELECTION.

  WRITE: / sy-vline, TEXT-005, 20 sy-vline, TEXT-006, lv_lines, 55 sy-vline.
  WRITE: / sy-uline(55).

TOP-OF-PAGE.

  WRITE: /  TEXT-007, sy-pagno.

END-OF-PAGE.

  WRITE: / TEXT-008, sy-pagno.
