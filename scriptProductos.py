import csv
import random
from datetime import datetime, timedelta

# Entradas
archivo_productos = 'productos.csv'
archivo_factura = 'factura.csv'
archivo_detalle = 'detalle_factura.csv'

cantidad_facturas = 500000
factura_id_inicial = 2015001
detalle_id_inicial = 2015001
producto_por_factura = (1, 3)

# Generar fecha aleatoria con :00 o :30
def fecha_random():
    start = datetime(2022, 1, 1)
    end = datetime.now()
    pasos_30min = int((end - start).total_seconds() // (30 * 60))
    minutos_random = random.randint(0, pasos_30min) * 30
    fecha = start + timedelta(minutes=minutos_random)
    return fecha.strftime('%Y-%m-%d %H:%M:%S')

# Leer productos (ID en columna 0, Precio en columna 3)
with open(archivo_productos, newline='', encoding='utf-8') as f:
    reader = csv.reader(f)
    productos = [(int(row[0]), float(row[3])) for row in reader]

# Generar facturas y detalles
with open(archivo_factura, 'w', newline='', encoding='utf-8') as f_factura, \
     open(archivo_detalle, 'w', newline='', encoding='utf-8') as f_detalle:
    
    writer_factura = csv.writer(f_factura)
    writer_detalle = csv.writer(f_detalle)

    factura_id = factura_id_inicial
    detalle_id = detalle_id_inicial

    for _ in range(cantidad_facturas):
        fecha = fecha_random()
        productos_factura = random.sample(productos, random.randint(*producto_por_factura))
        
        monto_total = 0
        for id_producto, precio in productos_factura:
            writer_detalle.writerow([
                detalle_id,
                factura_id,
                '',
                '',
                id_producto,
                1,
                round(precio, 2),
            ])
            monto_total += precio
            detalle_id += 1

        writer_factura.writerow([
            factura_id,
            round(monto_total, 2),
            fecha
        ])

        factura_id += 1

print("✔ Archivos generados. IDs comienzan en 2015001 para facturas y detalles.")
