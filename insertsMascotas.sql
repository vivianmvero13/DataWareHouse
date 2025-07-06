BULK INSERT veterinariaTX.dbo.mascotas
FROM 'C:\Users\vivia\Universidad\DataWH\insert_mascotas.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 1,
    BATCHSIZE = 100000,
    TABLOCK
);
