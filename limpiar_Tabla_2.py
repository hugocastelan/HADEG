import sys

def limpiar_tabla(tabla):
    # Dividir las filas de la tabla
    filas = tabla.split('\n')
    
    # Eliminar filas vacías o que comienzan con caracteres no deseados
    filas = [fila.strip() for fila in filas if fila.strip() and not fila.startswith('#') and not fila.startswith('*') and not fila.startswith('-')]
    
    # Dividir cada fila en columnas por tabuladores
    filas = [fila.split('\t') for fila in filas]
    
    # Eliminar espacios en blanco alrededor de cada columna
    filas = [[columna.strip() for columna in fila] for fila in filas]
    
    return filas

# Verificar si se proporciona el nombre del archivo como argumento
if len(sys.argv) > 1:
    archivo = sys.argv[1]
    
    try:
        # Leer el contenido del archivo
        with open(archivo, 'r') as file:
            tabla = file.read()
        
        # Llamar a la función para limpiar la tabla
        tabla_limpia = limpiar_tabla(tabla)
        
        # Agregar encabezados a la tabla limpia
        encabezados = ['gene', 'KO', 'thrshld', 'score', 'E-value', 'KO definition']
        tabla_limpia.insert(0, encabezados)
        
        # Imprimir la tabla limpia con separadores de tabulador
        for fila in tabla_limpia:
            print('\t'.join(fila))
    except FileNotFoundError:
        print("El archivo no existe.")
else:
    print("Debe proporcionar el nombre del archivo como argumento.")
