import csv

# Rutas de archivos
archivo_entrada = 't_cirugias.csv'  
archivo_salida = 't_cirugias_factura.csv'  

#id inicial
id_cirugia=2000001
# Procesar el CSV
with open(archivo_entrada, mode='r', newline='', encoding='utf-8') as entrada, \
     open(archivo_salida, mode='w', newline='', encoding='utf-8') as salida:
    lector = csv.reader(entrada)
    escritor = csv.writer(salida)
    for fila in lector:
        if len(fila) >= 3:
            # ID, Fecha, Monto, ID_Motivo, ID_Repetido
            id_val = id_cirugia
            fecha = fila[1]
            monto = fila[2]
            nueva_fila = [id_val, monto, fecha]
            escritor.writerow(nueva_fila)
            id_cirugia+=1

print("Archivo transformado guardado como:", archivo_salida)
