# Project : RAP Purchase Order Management

### 🧩 Description

A lightweight **Purchase Order Management System** built using RAP, supporting draft creation, validations, and approval workflow with Fiori Elements UI.

---

### ⚙️ Key Features

* Create and manage Purchase Orders (Header + Items)
* Draft handling (auto-save capability)
* Approval & Rejection workflow
* Validation logic (business rules)
* Annotation-driven UI (Fiori Elements)
* Clean separation of layers (DB → CDS → RAP → UI)

---

### 🏗️ Architecture

```
Database Tables (ZPO_HEADER, ZPO_ITEM)
        ↓
CDS Views (Interface + Consumption)
        ↓
RAP Business Object (Behaviour Definition & Implementation)
        ↓
OData Service
        ↓
Fiori Elements UI
```

---

### 🧠 Key Concepts Covered

* CDS View Modelling
* Associations & Compositions
* RAP Managed Scenario
* Draft Handling
* Actions (Approve/Reject)
* Annotations for UI generation
* Service Definition & Binding

---

### 📸 Screenshots

Screenshots of table structure, CDS, and UI (where applicable) are available inside the 'screenshots' folder.

---

## 🛠️ Tools & Technologies

* SAP ABAP (S/4HANA)
* Eclipse ADT
* RAP Framework
* CDS Views
* OData Services
* GitHub (for documentation & versioning)

---
