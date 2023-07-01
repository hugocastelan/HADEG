# -*- coding: utf-8 -*- # NAME [limpiar_tabla_3.py]	Version [1.0]
# AUTHOR  Hugo Castelan Sanchez 
# CREATED (2019-08)
# USAGE limpiar_tabla_3.py -f tabla > tabla_salida.txt 
# DESCRIPTION
#Limpiar tablas d
import argparse
import re

#Para parsear el archivo 
parser=argparse.ArgumentParser()
requiredNamed=parser.add_argument_group('required named arguments')
requiredNamed.add_argument('-f', '--file', help='table form proteinortho')

args=parser.parse_args()

# Abrir el archivo y leer las líneas
with open(args.file, 'r') as file:
    lineas = file.readlines()

# Eliminar caracteres no deseados y separar la tabla por tabuladores
tabla_limpiada = []
for linea in lineas:
    # Eliminar caracteres no deseados: #, *, -
    linea_limpiada = re.sub(r'[#*-]', '', linea)
    # Separar la tabla por tabuladores y/o comas
    fila = re.split(r',', linea_limpiada.strip())
    tabla_limpiada.append(fila)

# Imprimir la tabla separada por tabuladores
for fila in tabla_limpiada:
    print(','.join(fila))