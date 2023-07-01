library(tidyverse)
library(doBy)
library(ggplot2)


#csv_names <- list.files(path = "/Users/hugocastelan/Downloads/HADEG_blast_50/", pattern ="*.csv",full.names = T)
csv_names <- list.files(path = "C:/Users/jarva/Documents/UNAM/Semestre_8/Art_Genomica/Results_Blast/", pattern ="*.csv",full.names = T)

csv_names2 <- data.frame(genome = csv_names, id = as.factor(1:length(csv_names)))

data <- csv_names %>% lapply(read_csv) %>%  bind_rows(.id = as.character("id")) %>%left_join(csv_names2)

genomes<-as.factor(data$id)
datanew<-cbind(genomes,data)

#datos<-read.table("/Users/hugocastelan/Desktop/biosurfractante.tsv", sep="\t" , header = 1)
#datos<-read.table("C:/Users/jarva/Documents/UNAM/Semestre_7/Art_HADEG/HADEG/EggNOGmapper/pathways.csv", sep="," , header = 1)
datos<-read.table("C:/Users/jarva/Documents/UNAM/Semestre_8/Art_Genomica/Results_Blast/pathways.csv", sep="," , header = 1)

#colnames(datos)<-c("qseqid", "hydro","pathways")
colnames(datos)<-c("hydro","pathway","subpathway","query","gene")

df7<-datanew %>% group_by(genomes, genome, query)%>% summarise(n = n())

rrrr<-left_join(datos, df7, "query")

rrt<-orderBy(~genome, data=rrrr)

rrt2<-rrt[complete.cases(rrt),]

rrt2$genomes <- factor(rrt2$genomes, levels=c('1', '2', '3', '4', '5','6','7','8',"9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"))

df8<-rrt2 %>% group_by(genomes,pathway)%>% summarise(n = sum(n))
df9<-rrt2 %>% group_by(genomes,hydro)%>% summarise(n = sum(n))
df10<-rrt2 %>% group_by(genomes,gene)%>% summarise(n = sum(n))
df11<-rrt2 %>% group_by(hydro,gene,genomes)%>% summarise(n = sum(n))

write.table(df8,file =sprintf("ByPathway.csv"),sep=",", row.names=F)
write.table(df9,file =sprintf("ByGroup.csv"),sep=",", row.names=F)
write.table(df11,file =sprintf("ByHydro.csv"),sep=",", row.names=F)

ggplot(df8, aes(x=genomes, y = pathway))+geom_point(aes(size=n, colour = factor(genomes)))+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+theme(axis.text.y = element_text(size = 9),axis.text.x = element_text(size = 10))+ theme(legend.title = element_text(color = "black", size = 12),legend.text = element_text(color = "black", size = 12))
ggplot(df9, aes(x=genomes, y = hydro))+geom_point(aes(size=n))+theme_bw()+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+theme(axis.text.y = element_text(size = 9),axis.text.x = element_text(size = 10))+ theme(legend.title = element_text(color = "black", size = 12),legend.text = element_text(color = "black", size = 12))
ggplot(df10, aes(x=genomes, y = gene))+geom_point(aes(size=n))+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+theme(axis.text.y = element_text(size = 9),axis.text.x = element_text(size = 10))+ theme(legend.title = element_text(color = "black", size = 12),legend.text = element_text(color = "black", size = 12))


#ggplot(rrt2, aes(x =  genomes, y = pathways, color=pathways ))+geom_point(aes(size=n))+theme_bw()+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+ facet_wrap(~ hydro)+ theme(legend.position = "none") 


#ggplot(rrt2, aes(x=genomes, y = pathways, color=pathways))+geom_point(aes(size=n))+theme_bw()+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+ facet_wrap(~ hydro)+ theme(legend.position = "none") +theme(axis.text.y = element_text(size = 5),axis.text.x = element_text(size = 1)) 


#ggplot(rrt2, aes(x=genomes, y = pathways, color=pathways))+geom_point(aes(size=n))+theme_bw()+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+ facet_wrap(~ hydro)+theme(axis.text.y = element_text(size = 5),axis.text.x = element_text(size = 5))+ theme(legend.title = element_text(color = "black", size = 5),legend.text = element_text(color = "black", size = 5))




C<-c("1−Methylnaphthalene/2−Methylnaphthalene degradation"="goldenrod2",
"2−methylpropene degradation"="darkorange2",
"2−Nitrobenzoate degradation"="firebrick3",
"4−hydroxyphenylacetate degradation"="orangered",
"Anthranilate degradation"="maroon",
"Auxiliar alkane gene"="deeppink",
"Benzene degradation"="darkmagenta",
"Benzoate degradation"="mediumorchid4",
"Biphenyl degradation"="purple2",
"Catechol degradation"="purple4",
"Dimethylbenzene/toluene degradation"= "royalblue3",
"Ethene and chloroethene degradation"="royalblue3",
"Finnerty pathway"= "aquamarine4",
"Gentisate degradation"="mediumblue",
"Hydrocarbon uptake"="navy",
"Isoprene degradation"="dodgerblue4",
"Naphthalene degradation"="dodgerblue",
"Phenanthrene degradation"="purple2",
"Phenol degradation"="purple4",
"Phenylacetate degradation"="royalblue3",
"Phthalate degradation"="aquamarine4",
"Propene degradation"="mediumblue",
"Protocatechuate degradation"="navy",
"Salicylate degradation"="dodgerblue4",
"Subterminal oxidation"="dodgerblue",
"Terephthalate degradation"="orange4",
"Terminal/biterminal oxidation"="forestgreen",
"Toluene degradation"="darkolivegreen"))

+scale_fill_manual(values = c("goldenrod2", "darkorange2", "firebrick3", "orangered", "maroon", "deeppink", "darkmagenta", "mediumorchid4", "purple2","purple4", "royalblue3", "aquamarine4", "mediumblue", "navy", "dodgerblue4", "dodgerblue", "orange4",  "forestgreen", "darkolivegreen","chartreuse3", "olivedrab4", "olivedrab3", "sienna4", "sienna3", "sienna1"))


