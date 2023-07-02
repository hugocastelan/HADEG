library(tidyverse)
library(doBy)
library(ggplot2)

datos<-read.table("/Users/hugo/Downloads/table_ejemplo.csv", sep=",", header=T)
View(datos)

datos <- datos %>%
  separate(col = ref_all_hydrocarbons.faa, into = c("Query", "Gene"), sep = "\\|")


pathways<-read.table("/Users/hugo/Downloads/pathways.csv", sep="," , header = 1)

View(pathways)


resumen <- aggregate(. ~ Query + Gene, data = datos, FUN = sum)


df_m<-melt(resumen)
colnames(df_m)<-c("Query","Gene","Genome","Abundance")
df_m2<-left_join(df_m, pathways, "Query", relationship = "many-to-many")

df_filtered <- subset(df_m2, Abundance != 0)


ggplot(df_filtered, aes(x = Genome, y = Pathway)) +
        geom_point(aes(size = Abundance))+
      theme(
               axis.text.x = element_text(angle = 90, hjust = 1, size = 10))
