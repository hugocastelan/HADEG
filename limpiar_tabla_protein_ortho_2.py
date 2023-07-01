import argparse

# Para parsear el archivo
parser = argparse.ArgumentParser()
requiredNamed = parser.add_argument_group('required named arguments')
requiredNamed.add_argument('-f', '--file', help='table form proteinortho')
args = parser.parse_args()

# Abrir el archivo y leer las líneas
with open(args.file, 'r') as file:
    lineas = file.readlines()

# Obtener el encabezado y eliminar las tres primeras columnas
encabezado = lineas[0].strip().split('\t')[3:]

# Imprimir el encabezado
print('\t'.join(encabezado))

# Recorrer las filas de datos
for linea in lineas[1:]:
    fila = linea.strip().split('\t')
    
    # Obtener las columnas desde "ref_all_hydrocarbons.faa" en adelante
    columnas = fila[3:]
    columna_actual = ''
    nueva_fila = []
    
# Recorrer las columnas y separar en caso de encontrar una coma
    for col in columnas:
        if col != '':
            if col == columna_actual:
                nueva_fila.append('')  # Columna en blanco para mantener alineados los encabezados
            else:
                nueva_fila.append(col)
                columna_actual = col
        else:
            nueva_fila.append('')  # Columna en blanco para mantener alineados los encabezados
    
    # Imprimir la fila actual
    print('\t'.join(nueva_fila))

# Obtener las columnas desde la columna 2 en adelante
    columnas = fila[2:]
    nuevas_filas = [fila] 
    
# Recorrer las columnas y separar en caso de encontrar una coma
    for i in range(2, len(columnas)):
        if ',' in columnas[i]:
            valores_sep = columnas[i].split(',')
            nuevas_filas_temp = []  # Lista temporal para almacenar las nuevas filas generadas
            
            for val_sep in valores_sep:
                for nueva_fila in nuevas_filas:
                    nueva_fila_temp = nueva_fila[:i] + [val_sep] + nueva_fila[i+1:]
                    nuevas_filas_temp.append(nueva_fila_temp)
            
            nuevas_filas = nuevas_filas_temp
    
    # Imprimir todas las filas generadas
    for nueva_fila in nuevas_filas:
        print('\t'.join(nueva_fila))


   
