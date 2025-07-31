--- Obtener Mascota_D ---
SELECT 
  m.ID_MASCOTA AS ID_Mascota,
  m.MASCOTA_NOMBRE AS Nombre_Mascota,
  esp.DESCRIPCION_ESPECIE AS Especie,
  rz.NOMBRE_RAZA AS Raza,

  -- Rango de edad por categoria
  CASE 
    WHEN DATEDIFF(YEAR, m.MASCOTA_FECHA_NACIMIENTO, GETDATE()) < 2 THEN 'Cachorro'
    WHEN DATEDIFF(YEAR, m.MASCOTA_FECHA_NACIMIENTO, GETDATE()) BETWEEN 2 AND 7 THEN 'Adulto joven'
    ELSE 'Adulto'
  END AS Categoria_Edad,

  cl.NOMBRE_CLIENTE AS Nombre_Duenio,
  dst.NOMBRE_DISTRITO AS Distrito,
  cnt.NOMBRE_CANTON AS Canton,
  prv.NOMBRE_PROVINCIA AS Provincia

INTO veterinariaSA.tra.Mascotas_D 
FROM veterinariaSA.ext.mascotas m 
LEFT JOIN veterinariaSA.ext.mascota_raza rz
  ON m.ID_MASCOTA_RAZA = rz.ID_MASCOTA_RAZA
LEFT JOIN veterinariaSA.ext.mascota_especie esp
  ON rz.ID_MASCOTA_ESPECIE = esp.ID_MASCOTA_ESPECIE
LEFT JOIN veterinariaSA.ext.clientes cl
  ON m.ID_CLIENTE = cl.ID_CLIENTES
LEFT JOIN veterinariaSA.ext.distritos dst
  ON cl.DISTRITO_ID = dst.ID_DIRECCION_DISTRITO
LEFT JOIN veterinariaSA.ext.canton cnt
  ON dst.CANTON_ID = cnt.ID_DIRECCION_CANTON
LEFT JOIN veterinariaSA.ext.provincia prv
  ON cnt.PROVINCIA_ID = prv.ID_DIRECCION_PROVINCIA

-- Obtener fechaNacimiento_D --
SELECT DISTINCT
  CAST(MASCOTA_FECHA_NACIMIENTO AS DATE) AS Fecha_Nacimiento,
  DATEDIFF(YEAR, MASCOTA_FECHA_NACIMIENTO, GETDATE()) AS Annios,
  (DATEDIFF(MONTH, MASCOTA_FECHA_NACIMIENTO, GETDATE()) % 12) AS Meses
INTO veterinariaSA.tra.FechaNacimiento_D
FROM veterinariaSA.ext.mascotas
WHERE MASCOTA_FECHA_NACIMIENTO IS NOT NULL;

ALTER TABLE veterinariaSA.tra.FechaNacimiento_D
ALTER COLUMN Fecha_Nacimiento DATE NOT NULL;

ALTER TABLE veterinariaSA.tra.FechaNacimiento_D
ADD CONSTRAINT PK_FechaNacimiento PRIMARY KEY (Fecha_Nacimiento);


-- Obtener fechaServicio_D --
SELECT DISTINCT
  CAST(FACTURA.FECHA_FACTURA AS DATE) AS FechaServicio,
  DAY(FACTURA.FECHA_FACTURA) AS Dia,
  DATENAME(MONTH, FACTURA.FECHA_FACTURA) AS Mes,
  YEAR(FACTURA.FECHA_FACTURA) AS Anio
INTO veterinariaSA.tra.FechaServicio_D
FROM veterinariaSA.ext.factura FACTURA
WHERE FACTURA.FECHA_FACTURA IS NOT NULL;

ALTER TABLE veterinariaSA.tra.FechaServicio_D
ALTER COLUMN FechaServicio DATE NOT NULL;

ALTER TABLE veterinariaSA.tra.FechaServicio_D
ADD CONSTRAINT PK_FechaServicio PRIMARY KEY (FechaServicio);


-- Obtener Cirugia_D --

SELECT 
	c.ID_CIRUGIA AS idCirugia,
	tc.NOMBRE_CIRUGIA AS tipoCirugia,
	CASE 
		WHEN c.DURACION < 2 THEN 'Corta'
		WHEN c.DURACION BETWEEN 2 AND 4 THEN 'Media'
		Else  'Larga'
	END AS categoriaDuracion,
	c.DURACION AS tiempoDuracion,
	c.MONTO AS monto
INTO veterinariaSA.tra.Cirugia_D
FROM veterinariaSA.ext.cirugias c
JOIN veterinariaSA.ext.tipo_cirugia tc
	ON c.ID_TIPO_CIRUGIA = tc.ID_TIPO_CIRUGIA

--- Obtener Consulta_D ---
SELECT 
  c.ID_CONSULTA AS ID_Consulta,
  f.MONTO_TOTAL AS Monto,
  cm.DESCRIPCION_MOTIVO AS Motivo_Consulta

INTO veterinariaSA.tra.Consulta_D
FROM veterinariaSA.ext.consultas c
LEFT JOIN veterinariaSA.ext.consulta_motivo cm
  ON c.ID_MOTIVO = cm.ID_CONSULTA_MOTIVO

LEFT JOIN veterinariaSA.ext.detalle_factura df
  ON c.ID_CONSULTA = df.ID_CONSULTA

LEFT JOIN veterinariaSA.ext.factura f
  ON df.ID_FACTURA = f.ID_FACTURA

--- Obtener Producto_D ---
- Obtener Producto_D ---
SELECT 
  p.ID_PRODUCTO AS idProducto,
  p.PRODUCTO_NOMBRE AS Nombre,
  mp.NOMBRE_MARCA AS Marca,
  tp.NOMBRE_TIPO AS Tipo,
  p.PRODUCTO_PRECIO AS Monto,
  ISNULL(SUM(df.CANTIDAD), 0) AS ServicioVenta
INTO veterinariaSA.tra.Producto_D
FROM veterinariaSA.ext.productos p
JOIN veterinariaSA.ext.marca_producto mp
  ON p.ID_MARCA_PRODUCTO = mp.ID_MARCA_PRODUCTO
JOIN veterinariaSA.ext.tipo_producto tp
  ON p.ID_TIPO_PRODUCTO = tp.ID_TIPO_PRODUCTO
LEFT JOIN veterinariaSA.ext.detalle_factura df
  ON p.ID_PRODUCTO = df.ID_PRODUCTO
GROUP BY 
  p.ID_PRODUCTO,
  p.PRODUCTO_NOMBRE,
  mp.NOMBRE_MARCA,
  tp.NOMBRE_TIPO,
  p.PRODUCTO_PRECIO;

--- Obtener Servicios_H ---
SELECT 
  fsd.FechaServicio AS FECHA_SERVICIO,
  m.ID_CLIENTE,
  m.ID_MASCOTA,
  NULL AS ID_PRODUCTO,
  NULL AS ID_CONSULTA,
  c.ID_CIRUGIA AS ID_CIRUGIA,
  c.MONTO,
  CAST(m.MASCOTA_FECHA_NACIMIENTO AS DATE) AS ID_FECHA_NACIMIENTO
INTO veterinariaSA.tra.Servicio_H
FROM veterinariaSA.ext.cirugias c
JOIN veterinariaSA.ext.mascotas m ON c.ID_MASCOTA = m.ID_MASCOTA
JOIN veterinariaSA.tra.FechaServicio_D fsd ON CAST(c.FECHA_CIRUGIA AS DATE) = fsd.FechaServicio

UNION ALL

SELECT 
  fsd.FechaServicio,
  m.ID_CLIENTE,
  m.ID_MASCOTA,
  NULL,
  c.ID_CONSULTA,
  NULL,
  c.MONTO,
  CAST(m.MASCOTA_FECHA_NACIMIENTO AS DATE)
FROM veterinariaSA.ext.consultas c
JOIN veterinariaSA.ext.mascotas m ON c.ID_MASCOTA = m.ID_MASCOTA
JOIN veterinariaSA.tra.FechaServicio_D fsd ON CAST(c.FECHA_CONSULTA AS DATE) = fsd.FechaServicio

UNION ALL

SELECT 
  fsd.FechaServicio,
  NULL,
  NULL,
  df.ID_PRODUCTO,
  NULL,
  NULL,
  df.MONTO,
  NULL
FROM veterinariaSA.ext.detalle_factura df
JOIN veterinariaSA.ext.factura f ON df.ID_FACTURA = f.ID_FACTURA
JOIN veterinariaSA.tra.FechaServicio_D fsd ON CAST(f.FECHA_FACTURA AS DATE) = fsd.FechaServicio
WHERE df.ID_PRODUCTO IS NOT NULL;

