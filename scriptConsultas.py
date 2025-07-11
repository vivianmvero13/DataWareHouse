import csv
import random
from datetime import datetime, timedelta

#Numero de filas
num_rows = 2_000_000
filename = 't_consultas.csv'

# Rango de fechas
start_date = datetime(2022, 1, 1)
end_date = datetime.now()

# Generar una fecha aleatoria con minutos solo en 0 o 30
def generar_fecha_random():
    total_minutes = int((end_date - start_date).total_seconds() // 60)
    # Solo múltiplos de 30 minutos
    pasos_30min = total_minutes // 30
    paso_random = random.randint(0, pasos_30min)
    fecha = start_date + timedelta(minutes=paso_random * 30)
    return fecha.strftime('%Y-%m-%d %H:%M:%S')

# Generar CSV sin encabezado
with open(filename, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    for i in range(1, num_rows + 1):
        fecha = generar_fecha_random()
        monto = round(random.uniform(25000, 45000), 2)
        id_motivo = random.randint(1, 100)
        print(f"Dato #{i}:{i,fecha, monto, id_motivo, i}")
        writer.writerow([i, fecha, monto, id_motivo, i])

print(f"CSV '{filename}' generado correctamente con 2M de datos.")
