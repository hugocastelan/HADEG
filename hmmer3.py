import re
import csv
import os
import argparse

# Función para procesar un archivo de entrada y guardar los datos en formato CSV
def procesar_archivo(input_file):
    # Obtener el nombre base del archivo de entrada sin la extensión
    base_name = os.path.splitext(os.path.basename(input_file))[0]

    # Nombre del archivo de salida para los datos en formato CSV
    output_file = f"{base_name}_datos.csv"

    # Lista para almacenar los datos en formato CSV
    csv_data = []

    # Abrir el archivo de entrada y crear una lista de encabezados
    with open(input_file, 'r') as f:
        lines = f.readlines()

    # Encabezados de la tabla personalizados
    custom_headers = [
        "target name", "accession", "query name", "accession",
        "E-value", "score", "bias", "E-value", "score", "bias",
        "exp", "reg", "clu", "ov", "env", "dom", "rep", "inc", "description of target"]

    # Agregar los encabezados a la lista de datos CSV
    csv_data.append(custom_headers)

    # Procesar las líneas de datos
    for line in lines:
        if not line.startswith("#"):
            fields = line.strip().split()
            csv_data.append(fields)

    # Escribir los datos en un archivo de salida en formato CSV
    with open(output_file, 'w', newline='') as out_f:
        csv_writer = csv.writer(out_f)
        csv_writer.writerows(csv_data)

    print(f"Los datos se han guardado en '{output_file}' en formato CSV.")

# Configurar argumentos de línea de comandos
parser = argparse.ArgumentParser(description='Procesar archivos de hmmsearch y guardar los datos en formato CSV.')
parser.add_argument('input_files', nargs='+', help='Archivos de entrada de hmmsearch')

# Obtener la lista de archivos de entrada desde los argumentos
args = parser.parse_args()

# Procesar cada archivo de entrada
for input_file in args.input_files:
    procesar_archivo(input_file)
