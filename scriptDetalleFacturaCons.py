import csv

# Rutas de archivos
archivo_entrada = 't_consultas.csv'  
archivo_salida = 't_consultas_detalle_factura.csv'  


'''
Campo 1 - ID_Detalle Factura incremental
Campo 2 - ID_Factura incremental
Campo 3 - Incrementa de 1 a 2M (consultas) con CONSULTAS
Campo 4 - vacio
Campo 5 - vacío
campo 6 -cantidad siempre es 1
Campo 7 - precio de consulta/cirugia'''
# Procesar el CSV
with open(archivo_entrada, mode='r', newline='', encoding='utf-8') as entrada, \
     open(archivo_salida, mode='w', newline='', encoding='utf-8') as salida:
    lector = csv.reader(entrada)
    escritor = csv.writer(salida)
    for fila in lector:
        if len(fila) >= 3:
            # ID, Fecha, Monto, ID_Motivo, ID_Repetido
            id_detalle_factura = fila[0]
            monto = fila[2]
            nueva_fila = [id_detalle_factura,id_detalle_factura,id_detalle_factura,None,None,1,monto]
            escritor.writerow(nueva_fila)

print("Archivo transformado guardado como:", archivo_salida)
