| Field     | Key | Data Element | Data Type | Length | Decimal Places | Coordinate | Short Description                                      |
|-----------|-----|--------------|-----------|--------|----------------|------------|--------------------------------------------------------|
| PO_ID     | X   | EBELN        | CHAR      | 10     | 0              | 0          | Purchasing Document Number                             |
| VID       |     | LIFNR        | CHAR      | 10     | 0              | 0          | Account Number of Supplier                             |
| PO_DATE   |     | DATS         | DATS      | 8      | 0              | 0          | Field of type DATS                                     |
| STATUS    |     | Z_STAT       | CHAR      | 1      | 0              | 0          | Status                                                 |
| NETPR     |     | NETPR        | CURR      | 11     | 2              | 0          | Net Price                                              |
| WAERS     |     | WAERS        | CUKY      | 5      | 0              | 0          | Currency Key                                           |
| SYUNAME   |     | SYUNAME      | CHAR      | 12     | 0              | 0          | User Name                                              |
| TIMESTAMP |     | TIMESTAMP    | DEC       | 15     | 0              | 0          | UTC Time Stamp in Short Form (YYYYMMDDhhmmss)          |
