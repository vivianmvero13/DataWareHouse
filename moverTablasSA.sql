--Obtener tablas --
SELECT * INTO veterinariaSA.ext.provincia
FROM veterinariaTX.dbo.provincia;

SELECT * INTO veterinariaSA.ext.canton
FROM veterinariaTX.dbo.canton;

SELECT * INTO veterinariaSA.ext.distritos
FROM veterinariaTX.dbo.distritos;

-- Clientes
SELECT * INTO veterinariaSA.ext.clientes
FROM veterinariaTX.dbo.clientes;

-- Mascota
SELECT * INTO veterinariaSA.ext.mascota_especie
FROM veterinariaTX.dbo.mascota_especie;

SELECT * INTO veterinariaSA.ext.mascota_raza
FROM veterinariaTX.dbo.mascota_raza;

SELECT * INTO veterinariaSA.ext.mascotas
FROM veterinariaTX.dbo.mascotas;

-- Consultas
SELECT * INTO veterinariaSA.ext.consulta_motivo
FROM veterinariaTX.dbo.consulta_motivo;

SELECT * INTO veterinariaSA.ext.consultas
FROM veterinariaTX.dbo.consultas;

-- Cirugías
SELECT * INTO veterinariaSA.ext.cirugias_personal
FROM veterinariaTX.dbo.cirugias_personal;

SELECT * INTO veterinariaSA.ext.tipo_cirugia
FROM veterinariaTX.dbo.tipo_cirugia;

SELECT * INTO veterinariaSA.ext.cirugias
FROM veterinariaTX.dbo.cirugias;

-- Productos
SELECT * INTO veterinariaSA.ext.tipo_producto
FROM veterinariaTX.dbo.tipo_producto;

SELECT * INTO veterinariaSA.ext.marca_producto
FROM veterinariaTX.dbo.marca_producto;

SELECT * INTO veterinariaSA.ext.productos
FROM veterinariaTX.dbo.productos;

-- Relación cirugía-productos
SELECT * INTO veterinariaSA.ext.cirugias_medicamentos
FROM veterinariaTX.dbo.cirugias_medicamentos;

-- Facturación
SELECT * INTO veterinariaSA.ext.factura
FROM veterinariaTX.dbo.factura;

SELECT * INTO veterinariaSA.ext.detalle_factura
FROM veterinariaTX.dbo.detalle_factura;


