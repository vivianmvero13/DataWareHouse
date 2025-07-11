--- FACTURA CONSULTAS ---
BULK INSERT VETERINARIATX.DBO.FACTURA
FROM 'C:\Users\vivia\Universidad\DataWH\Proyecto\facturaConsultas.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIRSTROW = 1,
    TABLOCK
);

--- FACTURA PRODUCTOS ---
BULK INSERT VETERINARIATX.DBO.FACTURA
FROM 'C:\Users\vivia\Universidad\DataWH\Proyecto\facturaProductos.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIRSTROW = 1,
    TABLOCK
);

--- FACTURA CIRUGIAS ---
BULK INSERT VETERINARIATX.DBO.FACTURA
FROM 'C:\Users\vivia\Universidad\DataWH\Proyecto\facturaCirugias.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIRSTROW = 1,
    TABLOCK
);
