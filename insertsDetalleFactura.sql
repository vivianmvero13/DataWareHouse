--- DETALLE FACTURA CONSULTAS ---
BULK INSERT VETERINARIATX.DBO.DETALLE_FACTURA
FROM 'C:\Users\vivia\Universidad\DataWH\Proyecto\detalleFacturaConsultas.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIRSTROW = 1,
    TABLOCK
);

--- DETALLE FACTURA PRODUCTOS ---
BULK INSERT VETERINARIATX.DBO.DETALLE_FACTURA
FROM 'C:\Users\vivia\Universidad\DataWH\Proyecto\detalleFacturaProductos.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIRSTROW = 1,
    TABLOCK
);

--- DETALLE FACTURA CIRUGIAS ---
BULK INSERT VETERINARIATX.DBO.DETALLE_FACTURA
FROM 'C:\Users\vivia\Universidad\DataWH\Proyecto\detalleFacturaCirugias.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIRSTROW = 1,
    TABLOCK
);