# Lista de nombres de archivos .csv en el directorio
archivos_csv <- list.files(pattern = "\\.csv$")

# Iterar a través de los archivos
for (archivo in archivos_csv) {
  # Leer el archivo .csv
  datos <- read.csv(archivo)
  
  # Eliminar duplicados por la primera columna
  datos_sin_dup <- datos[!duplicated(datos[, 1]), ]
  
  # Crear el nuevo nombre de archivo
  nuevo_nombre <- sub(".csv$", "_sin_dup.csv", archivo)
  
  # Guardar el archivo sin duplicados
  write.csv(datos_sin_dup, file = nuevo_nombre, row.names = FALSE)
}