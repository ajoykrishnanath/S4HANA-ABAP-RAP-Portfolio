| Field   | Key | Data Element | Data Type | Length | Decimal Places | Coordinate | Short Description                     |
|---------|-----|--------------|-----------|--------|----------------|------------|---------------------------------------|
| PO_ID   | X   | SYSUUID_X16  | RAW       | 16     | 0              | 0          | 16 Byte UUID in 16 Bytes (Raw Format) |
| EBELP   | X   | EBELP        | NUMC      | 5      | 0              | 0          | Item Number of Purchasing Document    |
| MATNR   |     | MATNR        | CHAR      | 40     | 0              | 0          | Material Num                          |
| MENGE   |     | MENGE_D      | QUAN      | 13     | 3              | 0          | Quantity                              |
| MEINS   |     | MEINS        | UNIT      | 3      | 0              | 0          | Base Unit of Measure                  |
| NETPR   |     | NETPR        | CURR      | 11     | 2              | 0          | Net Price                             |
| WAERS   |     | WAERS        | CUKY      | 5      | 0              | 0          | Currency Key                          |
| NETWR   |     | NETWR        | CURR      | 15     | 2              | 0          | Net Value in Document Currency        |
