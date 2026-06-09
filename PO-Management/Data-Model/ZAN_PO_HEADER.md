| Field     | Key | Data Element | Data Type | Length | Decimal Places | Coordinate | Short Description                                      |
|-----------|-----|--------------|-----------|--------|----------------|------------|--------------------------------------------------------|
| PO_ID     | X   | SYSUUID_X16  | RAW       | 16     | 0              | 0          | 16 Byte UUID in 16 Bytes (Raw Format)                  |
| VID       |     | Z_VENDOR     | CHAR      | 10     | 0              | 0          | Vendor Id                                              |
| PO_DATE   |     | DATS         | DATS      | 8      | 0              | 0          | Field of type DATS                                     |
| STATUS    |     | Z_STAT       | CHAR      | 1      | 0              | 0          | Status                                                 |
| NETPR     |     | NETPR        | CURR      | 11     | 2              | 0          | Net Price                                              |
| WAERS     |     | WAERS        | CUKY      | 5      | 0              | 0          | Currency Key                                           |
| SYUNAME   |     | SYUNAME      | CHAR      | 12     | 0              | 0          | User Name                                              |
| TIMESTAMP |     | TIMESTAMP    | DEC       | 15     | 0              | 0          | UTC Time Stamp in Short Form (YYYYMMDDhhmmss)          |
