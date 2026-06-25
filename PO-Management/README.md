## Repository Structure

```text
S4HANA-ABAP-RAP-Portfolio
│
├── README.md
│
├── PO-Management
│   ├── README.md
│   │
│   ├── Screenshots
│   │   ├── PO_Home.png
│   │   ├── PO_Detail.png
│   │   └── PO_Creation_Draft.png
│   │
│   ├── Data-Model
│   │   ├── Draft-Table
│   │   └── Persistent-Table
│   │
│   ├── CDS
│   │   ├── Consumption
│   │   ├── Interface
│   │   └── Metadata-Extension
│   │
│   ├── Behavior-Definitions
│   │
│   ├── Behavior-Implementation
│   │
│   ├── Service-Definition
│   │
│   └── Service-Binding
```

## Business Process Flow

### Create Purchase Order

1. User creates a new Purchase Order.
2. System automatically:

   * Generates a unique Purchase Order Number.
   * Sets Status = `N` (New).
   * Captures Creation Timestamp.
3. User enters Header and Item details.
4. System performs validations:

   * Vendor Validation
   * Material Validation
   * Unit Validation
   * Currency Validation
   * Purchase Order Date Validation

### Submit Purchase Order

1. User clicks **Submit PO**.
2. System updates the Purchase Order Status from **N (New)** to **S (Submitted)**.
3. Further modifications are restricted using RAP Instance Feature Control.
4. Header and Item data become read-only.
5. Re-submission is prevented.

### Total Amount Calculation

* Total Purchase Order Amount is automatically calculated from Item data using RAP Determinations.
