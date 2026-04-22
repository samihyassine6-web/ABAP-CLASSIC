*&---------------------------------------------------------------------*
*& Report ZDEMOT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdemot.


DATA: lt_data TYPE TABLE OF zordh_28.
DATA: lv_value(10) TYPE c VALUE '20241203'.

SELECT * FROM zordh_28
  INTO TABLE lt_data
  WHERE odate = lv_value.

cl_demo_output=>display( lt_data ).
