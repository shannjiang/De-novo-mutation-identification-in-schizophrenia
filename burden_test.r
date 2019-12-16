library(dplyr)
###origin rr calculation
origin_list = read.table(file="permutation_DNM_lowDNMcountGene_removed.list",header = T,row.names=1,sep="\t")
#origin_pheno_count = as.data.frame(table(origin_list$diagnosis))
uniq_gene_list = unique(origin_list$gene)
uniq_gene_list = as.vector(uniq_gene_list)
#gene_origin_list = origin_list[origin_list$gene %in% uniq_gene_list[1],]
#gene_pheno_count = as.data.frame(table(gene_origin_list$diagnosis))
#origin_rr = (gene_pheno_count$Freq[2]/(gene_pheno_count$Freq[1]+gene_pheno_count$Freq[2]))/((origin_pheno_count$Freq[2]-gene_pheno_count$Freq[2])/(origin_pheno_count$Freq[2]-gene_pheno_count$Freq[2]+origin_pheno_count$Freq[1]-gene_pheno_count$Freq[1]))

perm_pvalue = vector(mode="numeric",length=length(uniq_gene_list))

for (i in 1:length(uniq_gene_list)) {

###origin rr calculation
gene_origin_list = origin_list[origin_list$gene %in% uniq_gene_list[i],]
gene_pheno_count = as.data.frame(table(gene_origin_list$diagnosis))
if (dim(gene_pheno_count)[1] == 2) {
origin_rr = (gene_pheno_count$Freq[2]/(gene_pheno_count$Freq[1]+gene_pheno_count$Freq[2]))/((origin_pheno_count$Freq[2]-gene_pheno_count$Freq[2])/(origin_pheno_count$Freq[2]-gene_pheno_count$Freq[2]+origin_pheno_count$Freq[1]-gene_pheno_count$Freq[1]))
} else {
if (gene_pheno_count$Var1[1] == 0) {
origin_rr = 0
}
if (gene_pheno_count$Var1[1] == 1) {
origin_rr = 1/((origin_pheno_count$Freq[2]-gene_pheno_count$Freq[1])/(origin_pheno_count$Freq[2]-gene_pheno_count$Freq[1]+origin_pheno_count$Freq[1]))
}
}

###perm rr calculation
perm_rr = replicate(10000, {
permed_diagnosis = sample(origin_list$diagnosis)
permed_origin_list = origin_list[,-1]
permed_origin_list = cbind(permed_diagnosis,permed_origin_list)
permed_gene_origin_list = permed_origin_list[permed_origin_list$gene %in% uniq_gene_list[i],]
permed_gene_pheno_count = as.data.frame(table(permed_gene_origin_list$permed_diagnosis))
origin_pheno_count = as.data.frame(table(origin_list$diagnosis))
permed_rr = (permed_gene_pheno_count$Freq[2]/(permed_gene_pheno_count$Freq[1]+permed_gene_pheno_count$Freq[2]))/((origin_pheno_count$Freq[2]-permed_gene_pheno_count$Freq[2])/(origin_pheno_count$Freq[2]-permed_gene_pheno_count$Freq[2]+origin_pheno_count$Freq[1]-permed_gene_pheno_count$Freq[1]))
return(permed_rr)
})
perm_pvalue[i] = (sum(length(which(perm_rr > origin_rr)) + 1)) / (length(perm_rr) + 1)
}
FDR_BH = p.adjust(perm_pvalue,method = "BH", n = length(perm_pvalue))
burden_test_permutation_result = cbind(uniq_gene_list, perm_pvalue, FDR_BH)
write.csv(burden_test_permutation_result,file="burden_test_10000permutation_result.csv")
