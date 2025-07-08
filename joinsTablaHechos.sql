SELECT 
-- DEBERIA USAR DF O F PARA DEFINIR ID_SERVICIO?--
  df.ID_DETALLE_FACTURA AS ID_Servicio,
  f.FECHA_FACTURA AS Fecha_Servicio,

	CASE 
		WHEN cons.ID_MASCOTA IS NOT NULL THEN cons.ID_MASCOTA
		WHEN cirg.ID_MASCOTA IS NOT NULL THEN cirg.ID_MASCOTA
		ELSE NULL
	END AS idMascota,

  -- obtener ID Cliente cuando es consutla o cirugia
	CASE 
		WHEN cons.ID_CONSULTA IS NOT NULL THEN clico.ID_CLIENTES
		WHEN cirg.ID_CIRUGIA IS NOT NULL THEN clici.ID_CLIENTES
		ELSE NULL
	 END AS ID_Cliente,

  --Obtener ID Mascota cuando es consulta o ciruga
	CASE 
		WHEN cons.ID_MASCOTA IS NOT NULL THEN cons.ID_MASCOTA
		WHEN cirg.ID_MASCOTA IS NOT NULL THEN cirg.ID_MASCOTA
		ELSE NULL
	END AS ID_Mascota,

  -- Obtener producto si este fue el servicio aplicado
	df.ID_PRODUCTOS AS ID_Producto,

  -- Obtener cirugia si este fue el servicio aplicado
	cirg.ID_CIRUGIA AS ID_Cirugia,

  -- Obtener consulta si este fue el servicio aplicado
	cons.ID_CONSULTA AS ID_Consulta,

  -- Obtener el monto del servicio
	f.MONTO_TOTAL AS Monto,

  -- Obtener fecha de nacimiento si es consulta o cirugia
	CASE 
		WHEN cons.ID_MASCOTA IS NOT NULL THEN masco.MASCOTA_FECHA_NACIMIENTO
		WHEN cirg.ID_MASCOTA IS NOT NULL THEN masci.MASCOTA_FECHA_NACIMIENTO
		ELSE NULL
	END AS ID_FechaNacimiento

FROM veterinariaSA.ext.detalle_factura df
JOIN veterinariaSA.ext.factura f
	ON df.ID_FACTURA = f.ID_FACTURA

-- CONSULTA MASCOTA CLIENTE
LEFT JOIN veterinariaSA.ext.consultas cons
	ON df.ID_CONSULTA = cons.ID_CONSULTA
LEFT JOIN veterinariaSA.ext.mascotas masco
	ON cons.ID_MASCOTA = masco.ID_MASCOTA
LEFT JOIN veterinariaSA.ext.clientes clico
	ON masco.ID_CLIENTE = clico.ID_CLIENTES

-- CIRUGIA  MEDICAMENTOS DETALLE_FACTURA
LEFT JOIN veterinariaSA.ext.cirugias_medicamentos cm
	ON df.ID_CIRUGIAS_MEDICAMENTOS = cm.ID_CIRUGIAS_MEDICAMENTOS
LEFT JOIN veterinariaSA.ext.cirugias cirg
	ON cm.ID_CIRUGIA = cirg.ID_CIRUGIA
LEFT JOIN veterinariaSA.ext.mascotas masci
	ON cirg.ID_MASCOTA = masci.ID_MASCOTA
LEFT JOIN veterinariaSA.ext.clientes clici
	ON masci.ID_CLIENTE = clici.ID_CLIENTES;
