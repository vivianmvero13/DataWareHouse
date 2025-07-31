-- Mascotas_D
SELECT * INTO veterinariaDW.dbo.Mascotas_D
FROM veterinariaSA.tra.Mascotas_D;
ALTER TABLE veterinariaDW.dbo.Mascotas_D ADD PRIMARY KEY(ID_Mascota);

-- FechaNacimiento_D
SELECT * INTO veterinariaDW.dbo.FechaNacimiento_D
FROM veterinariaSA.tra.FechaNacimiento_D;
ALTER TABLE veterinariaDW.dbo.FechaNacimiento_D ADD PRIMARY KEY(Fecha_Nacimiento)
DROP TABLE IF EXISTS veterinariaDW.dbo.FechaNacimiento_D;

CREATE TABLE veterinariaDW.dbo.FechaNacimiento_D (
  Fecha_Nacimiento DATE NOT NULL PRIMARY KEY,
  Annios INT NOT NULL,
  Meses INT NOT NULL
);

INSERT INTO veterinariaDW.dbo.FechaNacimiento_D (Fecha_Nacimiento, Annios, Meses)
SELECT Fecha_Nacimiento, Annios, Meses
FROM veterinariaSA.tra.FechaNacimiento_D;


-- FechaServicio_D
SELECT * INTO veterinariaDW.dbo.FechaServicio_D
FROM veterinariaSA.tra.FechaServicio_D;

-- Cirugia_D
SELECT * INTO veterinariaDW.dbo.Cirugia_D
FROM veterinariaSA.tra.Cirugia_D;
ALTER TABLE veterinariaDW.dbo.Cirugia_D ADD PRIMARY KEY(idCirugia);

-- Consulta_D
SELECT * INTO veterinariaDW.dbo.Consulta_D
FROM veterinariaSA.tra.Consulta_D;
ALTER TABLE veterinariaDW.dbo.Consulta_D ADD PRIMARY KEY(ID_Consulta);

-- Producto_D
SELECT * INTO veterinariaDW.dbo.Producto_D
FROM veterinariaSA.tra.Producto_D;
ALTER TABLE veterinariaDW.dbo.Producto_D ADD PRIMARY KEY(idProducto);

-- Servicio_H (tabla de hechos)
SELECT * INTO veterinariaDW.dbo.Servicio_H
FROM veterinariaSA.tra.Servicio_H;
ALTER TABLE veterinariaDW.dbo.Servicio_H  ADD PRIMARY KEY(ID_SERVICIO)


-- FK a FechaServicio_D
ALTER TABLE veterinariaDW.dbo.Servicio_H
ADD CONSTRAINT FK_Servicio_FechaServicio
FOREIGN KEY (FECHA_SERVICIO)
REFERENCES veterinariaDW.dbo.FechaServicio_D(FechaServicio);

-- FK a FechaNacimiento_D
ALTER TABLE veterinariaDW.dbo.Servicio_H
ADD CONSTRAINT FK_Servicio_FechaNacimiento
FOREIGN KEY (ID_FECHA_NACIMIENTO)
REFERENCES veterinariaDW.dbo.FechaNacimiento_D(Fecha_Nacimiento);

-- FK a Mascotas_D
ALTER TABLE veterinariaDW.dbo.Servicio_H
ADD CONSTRAINT FK_Servicio_Mascota
FOREIGN KEY (ID_MASCOTA)
REFERENCES veterinariaDW.dbo.Mascotas_D(ID_Mascota);

-- FK a Consulta_D
ALTER TABLE veterinariaDW.dbo.Servicio_H
ADD CONSTRAINT FK_Servicio_Consulta
FOREIGN KEY (ID_CONSULTA)
REFERENCES veterinariaDW.dbo.Consulta_D(ID_Consulta);

-- FK a Cirugia_D
ALTER TABLE veterinariaDW.dbo.Servicio_H
ADD CONSTRAINT FK_Servicio_Cirugia
FOREIGN KEY (ID_CIRUGIA)
REFERENCES veterinariaDW.dbo.Cirugia_D(idCirugia);

-- FK a Producto_D
ALTER TABLE veterinariaDW.dbo.Servicio_H
ADD CONSTRAINT FK_Servicio_Producto
FOREIGN KEY (ID_PRODUCTO)
REFERENCES veterinariaDW.dbo.Producto_D(idProducto);
