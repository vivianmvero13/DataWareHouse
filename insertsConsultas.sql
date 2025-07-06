BULK INSERT VETERINARIATX.DBO.CONSULTAS
FROM 'C:\Users\vivia\Universidad\DataWH\Proyecto\consultas.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 1,
    BATCHSIZE = 100000,
    TABLOCK
);
