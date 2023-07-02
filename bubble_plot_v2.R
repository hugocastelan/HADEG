library(tidyverse)
library(doBy)
library(ggplot2)
install.packages("svglite")
library(svglite)

datos<-read.table("/Users/hugo/Downloads/FINAL_50_03_bubble.csv", sep=",", header=T)
View(datos)

datos <- datos %>%
  separate(col = ref_all_hydrocarbons.faa, into = c("Query", "Gene"), sep = "\\|")


pathways<-read.table("/Users/hugo/Downloads/pathways.csv", sep="," , header = 1)

View(pathways)


resumen <- aggregate(. ~ Query + Gene, data = datos, FUN = sum)
View()

df_m<-melt(resumen)

colnames(df_m)<-c("Query","Gene","Genome","Abundance")
df_m2<-left_join(df_m, pathways, "Query", relationship = "many-to-many")

df_m3<-df_m2 %>% group_by(Genome,Pathway, Hydro)%>% summarise(n = sum(Abundance))

df_m3<-cbind(df_m3, nombres_genomas_bien$Type, nombres_genomas_bien$Genomes)

df_filtered <- subset(df_m3, n != 0)

ggplot(df_filtered, aes(x = Genome, y = Pathway)) +
        geom_point(aes(size =n))+
      theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 9))+
      theme(axis.text.y =  element_text(hjust = 1, size = 7))+
      facet_grid(~Hydro)
                                                                                                           ))
##SEPARADOS POR GRUPOS 
svglite("figure_buble.svg", width = 15,height = 15)
ggplot() +
  geom_point(data = subset(df_filtered_facet, Type == "Alkenes"), aes(x = Genome, y = Pathway, size = n)) +
  geom_point(data = subset(df_filtered_facet, Type == "Alkanes"), aes(x = Genome, y = Pathway, size = n)) +
  geom_point(data = subset(df_filtered_facet, Type == "Aromatics"), aes(x = Genome, y = Pathway, size = n)) +
  geom_point(data = subset(df_filtered_facet, Type == "Plastic"), aes(x = Genome, y = Pathway, size = n)) +
  geom_point(data = subset(df_filtered_facet, Type == "Control"), aes(x = Genome, y = Pathway, size = n)) +
  geom_point(data = subset(df_filtered_facet, Type == "Biosurfactants"), aes(x = Genome, y = Pathway, size = n)) +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust = 1, size = 10)) +
  theme(axis.text.y = element_text(hjust = 1, size = 10)) +
  facet_grid(~ Type, scales = "free_x", space = "free")

dev.off()

