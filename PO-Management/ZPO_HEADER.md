| Field         | Key Field | Data Element | Data Type | Length | Decimals | Coordinate | Short Text                                  |
|--------------|----------|--------------|----------|--------|----------|------------|------------------------------------------------|
| PO_ID        | X        | SYSUUID_X16  | RAW      | 16     | 0        | 0          | 16 Byte UUID in 16 Bytes (Raw Format)          |
| VENDOR_ID    |          | Z_VENDOR     | CHAR     | 10     | 0        | 0          | Vendor Id                                      |
| PO_DATE      |          | DATS         | DATS     | 8      | 0        | 0          | Field of type DATS                             |
| STATUS       |          | ZSTATUS      | CHAR     | 1      | 0        | 0          | Status                                         |
| TOTAL_AMOUNT |          | Z_CURR       | DEC      | 17     | 4        | 0          | Amount                                         |
| CURRENCY     |          | WAERS        | CUKY     | 5      | 0        | 0          | Currency Key                                   |
| CREATED_BY   |          | SYUNAME      | CHAR     | 12     | 0        | 0          | User Name                                      |
| CREATED_ON   |          | TIMESTAMP    | DEC      | 15     | 0        | 0          | UTC Time Stamp in Short Form (YYYYMMDDhhmmss)  |
