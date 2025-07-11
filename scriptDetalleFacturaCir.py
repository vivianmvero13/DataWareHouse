import csv

# Rutas de archivos
archivo_entrada = 't_cirugias.csv'  
archivo_salida = 't_cirugias_detalle_factura.csv'  
'''
Campo 1 - ID_Detalle Factura incremental
Campo 2 - ID_Factura incremental
Campo 3 - vacio
Campo 4 - ID 
Campo 5 - vacío
campo 6 -cantidad siempre es 1
Campo 7 - precio de consulta/cirugia'''
# Procesar el CSV

id_cirugia=2000001
id_cirugia_aux=1
with open(archivo_entrada, mode='r', newline='', encoding='utf-8') as entrada, \
     open(archivo_salida, mode='w', newline='', encoding='utf-8') as salida:
    lector = csv.reader(entrada)
    escritor = csv.writer(salida)
    for fila in lector:
        if len(fila) >= 3:
            id_detalle_cirugia = id_cirugia
            monto = fila[2]
            nueva_fila = [id_detalle_cirugia,id_detalle_cirugia,None,id_cirugia_aux,None,1,monto]
            escritor.writerow(nueva_fila)
            id_cirugia+=1
            id_cirugia_aux+=1

print("Archivo transformado guardado como:", archivo_salida)
