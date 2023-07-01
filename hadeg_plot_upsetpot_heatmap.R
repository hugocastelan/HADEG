library(readr)
library(ComplexHeatmap)
library("circlize")
library("RColorBrewer")
library(patchwork)

vias_comparison <- read_csv("Downloads/vias_comparison.csv")
metadata_hydrocarbos <- read_excel("Downloads/metadata_hydrocarbos.xlsx")

m = make_comb_mat(vias_comparison)
A<-UpSet(m, comb_col = "#003049", bg_col = c("#ffffff", "#e5e5e5"), bg_pt_col = "#d6ccc2",comb_order = order(comb_size(m)))


vias.t<-t(vias_comparison)

nuevos_nombres <- metadata_hydrocarbos$Pathway
colnames(vias.t) <- nuevos_nombres
matriz_sin_primera_fila <- vias.t[-1, ]
matrix2<-as.matrix(matriz_sin_primera_fila)
head(matrix2)
colores <- c("#e5e5e5", "#003049")
column_names_gp <- gpar(fontsize = 6)
colores_annotation <- list(Pathway_group =c("A_Alkanes" ="red","B_Alkenes" = "#ff00ffff","C_Aromatics" = "#f0e442ff", "D_Plastic" = "#e69f00ff",  "E_Biosurfactants" ="#56b4e9ff","F_Anerobic" ="gray47"))
column_ha = HeatmapAnnotation(Pathway_group= metadata_hydrocarbos$Hydro, col = colores_annotation)
B<-Heatmap(matrix2, name = "Present",top_annotation = column_ha, show_column_names = T,cluster_columns = T, col = colores,row_names_side = "left", column_names_gp = column_names_gp, heatmap_width = unit(20, "cm"))

B+A
