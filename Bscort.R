library(tidyverse)


args <- commandArgs(TRUE)
file_in <- as.character(args[1])
#leemos archivo
datos <- read.table(file_in,sep="\t", header=T)
#Filtramos
filter<-datos %>%group_by(seqid) %>%arrange(bitscore) %>% filter(bitscore == max(bitscore))
#Escribimos archivo
write.table(filter, file=sprintf("%s.csv",file_in),sep=",", row.names=F)


