import os
import pandas as pd

# Define el encabezado común que deseas establecer en todos los archivos CSV.
nuevo_encabezado = [
    "target name", "accession", "query", "accession", "E-value",
    "score", "bias", "E-value", "score", "bias", "exp", "reg", "clu",
    "ov", "env", "dom", "rep", "inc", "description of target"
]

# Ruta al directorio que contiene los archivos CSV.
directorio_archivos_csv = "/Users/hugo/Desktop/canthyd"

# Lista de nombres de archivos CSV en el directorio.
archivos_csv = [archivo for archivo in os.listdir(directorio_archivos_csv) if archivo.endswith(".csv")]

# Itera a través de los archivos CSV y cambia el encabezado si coincide con la estructura.
for archivo in archivos_csv:
    ruta_completa = os.path.join(directorio_archivos_csv, archivo)
    
    # Lee el archivo CSV en un DataFrame de pandas.
    df = pd.read_csv(ruta_completa)
    
    # Verifica si el número de columnas coincide con la estructura esperada.
    if len(df.columns) == len(nuevo_encabezado):
        df.columns = nuevo_encabezado
        df.to_csv(ruta_completa, index=False)
        print(f"Encabezado cambiado en {archivo}.")
    else:
        print(f"Ignorando {archivo} ya que tiene una estructura diferente.")

print("Proceso completo.")
