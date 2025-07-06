BULK INSERT veterinariaTX.dbo.clientes
FROM 'C:\Users\vivia\Universidad\DataWH\insert_clientes.csv'
WITH (
    FORMATFILE = 'C:\Users\vivia\Downloads\clientes_fmt_correcto.fmt',
    BATCHSIZE = 100000,
    TABLOCK
);