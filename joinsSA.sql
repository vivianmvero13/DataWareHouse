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

FROM veterinariaSA.ext.mascotas m
JOIN veterinariaSA.ext.mascota_raza rz
  ON m.ID_MASCOTA_RAZA = rz.ID_MASCOTA_RAZA
JOIN veterinariaSA.ext.mascota_especie esp
  ON rz.ID_MASCOTA_ESPECIE = esp.ID_MASCOTA_ESPECIE
JOIN veterinariaSA.ext.clientes cl
  ON m.ID_CLIENTE = cl.ID_CLIENTES
JOIN veterinariaSA.ext.distritos dst
  ON cl.DISTRITO_ID = dst.ID_DIRECCION_DISTRITO
JOIN veterinariaSA.ext.canton cnt
  ON dst.CANTON_ID = cnt.ID_DIRECCION_CANTON
JOIN veterinariaSA.ext.provincia prv
  ON cnt.PROVINCIA_ID = prv.ID_DIRECCION_PROVINCIA;

-- Obtener fechaNacimiento_D --
SELECT 
  m.MASCOTA_FECHA_NACIMIENTO AS Fecha_Nacimiento,
  DATEDIFF(YEAR, m.MASCOTA_FECHA_NACIMIENTO, GETDATE()) AS Annios,
  (DATEDIFF(MONTH, m.MASCOTA_FECHA_NACIMIENTO, GETDATE()) % 12) AS Meses
FROM veterinariaSA.ext.mascotas m;

-- Obtener fechaServicio_D --
SELECT 
  fact.FECHA_FACTURA AS FechaServicio,
  DAY(fact.FECHA_FACTURA) AS Dia,
  DATENAME(MONTH, fact.FECHA_FACTURA) AS Mes,
  YEAR(fact.FECHA_FACTURA) AS Anio
FROM veterinariaSA.ext.factura fact;

-- Obtener Cirugia_D --
--- *********PEDIR AYUDA AL PROFE PARA CALCULAR EL MONTO FINAL********* ---
SELECT 
	c.ID_CIRUGIA,
	tc.NOMBRE_CIRUGIA AS tipo,
	CASE 
		WHEN c.DURACION < 2 THEN 'Corta'
		WHEN c.DURACION BETWEEN 2 AND 4 THEN 'Media'
		Else  'Larga'
	END AS categoriaDuracion

FROM veterinariaSA.ext.cirugias c
JOIN veterinariaSA.ext.tipo_cirugia tc
	ON c.ID_TIPO_CIRUGIA = tc.ID_TIPO_CIRUGIA

LEFT JOIN veterinariaSA.ext.cirugias_medicamentos cm
	ON c.ID_CIRUGIA = cm.ID_CIRUGIA;

--- Obtener Consulta_D ---
SELECT 
  c.ID_CONSULTA AS ID_Consulta,
  f.MONTO_TOTAL AS Monto,
  cm.DESCRIPCION_MOTIVO AS Motivo_Consulta

FROM veterinariaSA.ext.consultas c
JOIN veterinariaSA.ext.consulta_motivo cm
  ON c.ID_MOTIVO = cm.ID_CONSULTA_MOTIVO

JOIN veterinariaSA.ext.detalle_factura df
  ON c.ID_CONSULTA = df.ID_CONSULTA

JOIN veterinariaSA.ext.factura f
  ON df.ID_FACTURA = f.ID_FACTURA;

--- Obtener Producto_D ---
SELECT 
  p.ID_PRODUCTO AS idProducto,
  p.PRODUCTO_NOMBRE AS Nombre,
  mp.NOMBRE_MARCA AS Marca,
  tp.NOMBRE_TIPO AS Tipo

FROM veterinariaTX.dbo.productos p
JOIN veterinariaTX.dbo.marca_producto mp
  ON p.ID_MARCA_PRODUCTO = mp.ID_MARCA_PRODUCTO
JOIN veterinariaTX.dbo.tipo_producto tp
  ON p.ID_TIPO_PRODUCTO = tp.ID_TIPO_PRODUCTO;
