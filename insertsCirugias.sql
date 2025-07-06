BULK INSERT VETERINARIATX.DBO.CIRUGIAS
FROM 'C:\Users\vivia\Universidad\DataWH\Proyecto\cirugias.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 1,
    BATCHSIZE = 10000,
    TABLOCK
);
