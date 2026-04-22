# Classic ABAP Reports & CRUD Operations

## Overview

This repository demonstrates **classical ABAP development techniques** using procedural programming and standard SAP reporting tools.

It focuses on:

* Classical ABAP List Reports
* Modularization using FORM routines
* Database operations (CRUD)
* User interaction via selection screens

---

## Features

* Classical ABAP report programming
* Selection screens with parameters and select-options
* List output using WRITE statements
* Modularization using FORM routines
* Database operations (Create, Read, Update, Delete)
* Basic user input handling

---

## Functionalities

### Selection Screen

* Input parameters for filtering data
* Dynamic user-driven report execution

```abap id="6c9i8y"
PARAMETERS: p_cust TYPE zcustomer.
SELECT-OPTIONS: s_date FOR sy-datum.
```

---

### Data Retrieval (READ)

```abap id="gk3rra"
SELECT * FROM zsales
  INTO TABLE lt_sales
  WHERE customer = p_cust.
```

---

### Create (INSERT)

```abap id="4qf5e8"
INSERT zsales FROM ls_sales.
```

---

### Update (MODIFY)

```abap id="b78u3k"
MODIFY zsales FROM ls_sales.
```

---

### Delete (DELETE)

```abap id="m31g2v"
DELETE FROM zsales WHERE sales_id = lv_id.
```

---

### Output (Classic List)

```abap id="p9p8m1"
LOOP AT lt_sales INTO ls_sales.
  WRITE: / ls_sales-sales_id, ls_sales-amount.
ENDLOOP.
```

---

## Architecture

* Procedural ABAP
* Modularization using FORM routines
* Separation of logic into:

  * Data selection
  * Processing
  * Output

---

## Technologies

* Classical ABAP
* Open SQL
* Internal Tables
* Selection Screens

---

## Purpose

This project demonstrates foundational ABAP development skills and understanding of legacy systems still widely used in enterprise environments.

It highlights the ability to work with:

* Existing SAP systems (ECC / classic environments)
* Procedural programming
* Database-driven reporting

---

## System

Developed in SAP NetWeaver AS ABAP 7.52 Developer Edition.

---

## Author

Yassine
