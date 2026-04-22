*&---------------------------------------------------------------------*
*& Report ZPRG_FIELD_SYMBOLS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_field_symbols.

*DATA: lv_data(2) TYPE n VALUE 10.
*FIELD-SYMBOLS: <fs_data> TYPE n.  " Typed Field Symbol
*
*ASSIGN lv_data TO <fs_data>.
*IF <fs_data> IS ASSIGNED.
*  <fs_data> = 20.
*  WRITE: / lv_data.
*ENDIF.

DATA: lv_value(50) TYPE c VALUE 'Welcome to Home'.
FIELD-SYMBOLS: <fs_value> TYPE c.

ASSIGN lv_value+8(2) TO <fs_value>.
IF <fs_value> IS ASSIGNED.  " always check if assigned
  <fs_value> = 'at'.
  WRITE: / lv_value.
ENDIF.
