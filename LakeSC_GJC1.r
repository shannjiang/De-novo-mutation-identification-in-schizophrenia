library(dplyr)
library(Seurat)
library(ggplot2)

setwd("H:/SCZ_brain_developmental_analsyis/SingleCell/Lake")
lname = load(file="lake_brain_cell_umi4seurat_v2.RData")
lake_braincell = CreateSeuratObject(counts = lake_braincell_umi_matrix,project = "lake_SC", min.cells = 0, min.features = 0)
lake_braincell = NormalizeData(lake_braincell, normalization.method = "LogNormalize", scale.factor = 10000)
lake_braincell_normalized_data = lake_braincell[["RNA"]]@data
lake_braincell_normalized_data = as.data.frame(lake_braincell_normalized_data)
lake_braincell_normalized_data_t = as.data.frame(t(lake_braincell_normalized_data))
lake_braincell_normalized_data_with_cell_label = data.frame(lake_branicell_umi_colnames,lake_braincell_normalized_data_t)
colnames(lake_braincell_normalized_data_with_cell_label)[1] = "cell_type"
lake_braincell_normalized_data_with_cell_label_noNA = lake_braincell_normalized_data_with_cell_label[!(lake_braincell_normalized_data_with_cell_label$cell_type %in% "NA"),]
#lake_braincell_normalized_data_with_cell_label_noNA$cell_type = factor(lake_braincell_normalized_data_with_cell_label_noNA$cell_type, levels = c("Oligo","Astro","OPC","Endo","Microglia","Per","Ex1","Ex2","Ex3e","Ex4","Ex5b","Ex6a","Ex6b","Ex8","Ex9","In1a","In1b","In1c","In3","In4a","In4b","In6a","In6b","In7","In8"))
lake_braincell_normalized_data_with_cell_label_noNA$cell_type = factor(lake_braincell_normalized_data_with_cell_label_noNA$cell_type, levels = c("In1a","In1b","In1c","In3","In4a","In4b","In6a","In6b","In7","In8","Ex1","Ex2","Ex3e","Ex4","Ex5b","Ex6a","Ex6b","Ex8","Ex9","Oligo","Astro","OPC","Endo","Microglia","Per"))
levels(lake_braincell_normalized_data_with_cell_label_noNA$cell_type) = c("GABAergic_In1a","GABAergic_In1b","GABAergic_In1c","GABAergic_In3","GABAergic_In4a","GABAergic_In4b","GABAergic_In6a","GABAergic_In6b","GABAergic_In7","GABAergic_In8","Glutamatergic_Ex1","Glutamatergic_Ex2","Glutamatergic_Ex3e","Glutamatergic_Ex4","Glutamatergic_Ex5b","Glutamatergic_Ex6a","Glutamatergic_Ex6b","Glutamatergic_Ex8","Glutamatergic_Ex9","Non-neuronal_Oligo","Non-neuronal_Astro","Non-neuronal_OPC","Non-neuronal_Endo","Non-neuronal_Microglia","Non-neuronal_Per")
p = ggplot(lake_braincell_normalized_data_with_cell_label_noNA, aes(x=cluster,y=GJC1)) + geom_violin() + geom_jitter(shape=16, position = position_jitter(0.2)) + coord_flip()
pdf("Lake_GJC1.pdf",width = 7, height = 7)
p
dev.off()
