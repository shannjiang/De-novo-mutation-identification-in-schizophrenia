library(SKAT)
setwd("H:/De_novo/SCZ_sweden_wes")
##SCZvsCO
swe_filtered_BP_removed_HIST1H2AD_GJC1.Bed = "./swe_filtered_BP_removed_HIST1H2AD_GJC1.bed"
swe_filtered_BP_removed_HIST1H2AD_GJC1.Bim = "./swe_filtered_BP_removed_HIST1H2AD_GJC1.bim"
swe_filtered_BP_removed_HIST1H2AD_GJC1.Fam = "./swe_filtered_BP_removed_HIST1H2AD_GJC1.fam"
swe_filtered_BP_removed_HIST1H2AD_GJC1.SetID = "./swe_HIST1H2AD_GJC1_SNPset_ID"
swe_filtered_BP_removed_HIST1H2AD_GJC1.SSD = "./swe_filtered_BP_removed_HIST1H2AD_GJC1.SSD"
swe_filtered_BP_removed_HIST1H2AD_GJC1.Info = "./swe_filtered_BP_removed_HIST1H2AD_GJC1.Info"
swe_filtered_BP_removed_HIST1H2AD_GJC1.Cov = "./swe_filtered_BP_removed_HIST1H2AD_GJC1.cov"

Generate_SSD_SetID(swe_filtered_BP_removed_HIST1H2AD_GJC1.Bed, swe_filtered_BP_removed_HIST1H2AD_GJC1.Bim, swe_filtered_BP_removed_HIST1H2AD_GJC1.Fam, swe_filtered_BP_removed_HIST1H2AD_GJC1.SetID, swe_filtered_BP_removed_HIST1H2AD_GJC1.SSD, swe_filtered_BP_removed_HIST1H2AD_GJC1.Info)

FAM = Read_Plink_FAM(swe_filtered_BP_removed_HIST1H2AD_GJC1.Fam, Is.binary=FALSE)
y = FAM$Phenotype
y = y - 1
SSD.INFO = Open_SSD(swe_filtered_BP_removed_HIST1H2AD_GJC1.SSD, swe_filtered_BP_removed_HIST1H2AD_GJC1.Info)

obj = SKAT_Null_Model(y ~ 1, out_type = "D")
out = SKAT.SSD.All(SSD.INFO, obj)

swe_filtered_BP_removed_HIST1H2AD_GJC1_Cov = Read_Plink_FAM_Cov(swe_filtered_BP_removed_HIST1H2AD_GJC1.Fam, swe_filtered_BP_removed_HIST1H2AD_GJC1.Cov, Is.binary = TRUE)
X1 = swe_filtered_BP_removed_HIST1H2AD_GJC1_Cov$Sex.y
obj = SKAT_Null_Model(y ~ X1, out_type = "D")
out = SKAT.SSD.All(SSD.INFO,obj)

#BPvsCO
swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Bed = "./swe_filtered_SCZ_removed_HIST1H2AD_GJC1.bed"
swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Bim = "./swe_filtered_SCZ_removed_HIST1H2AD_GJC1.bim"
swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Fam = "./swe_filtered_SCZ_removed_HIST1H2AD_GJC1.fam"
swe_filtered_SCZ_removed_HIST1H2AD_GJC1.SetID = "./swe_HIST1H2AD_GJC1_SNPset_ID"
swe_filtered_SCZ_removed_HIST1H2AD_GJC1.SSD = "./swe_filtered_SCZ_removed_HIST1H2AD_GJC1.SSD"
swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Info = "./swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Info"
swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Cov = "./swe_filtered_SCZ_removed_HIST1H2AD_GJC1.cov"

Generate_SSD_SetID(swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Bed, swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Bim, swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Fam, swe_filtered_SCZ_removed_HIST1H2AD_GJC1.SetID, swe_filtered_SCZ_removed_HIST1H2AD_GJC1.SSD, swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Info)

FAM = Read_Plink_FAM(swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Fam, Is.binary=FALSE)
y = FAM$Phenotype
y = y - 1
SSD.INFO = Open_SSD(swe_filtered_SCZ_removed_HIST1H2AD_GJC1.SSD, swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Info)

obj = SKAT_Null_Model(y ~ 1, out_type = "D")
out = SKAT.SSD.All(SSD.INFO, obj)

swe_filtered_SCZ_removed_HIST1H2AD_GJC1_Cov = Read_Plink_FAM_Cov(swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Fam, swe_filtered_SCZ_removed_HIST1H2AD_GJC1.Cov, Is.binary = TRUE)
X1 = swe_filtered_SCZ_removed_HIST1H2AD_GJC1_Cov$Sex.y
obj = SKAT_Null_Model(y ~ X1, out_type = "D")
out = SKAT.SSD.All(SSD.INFO,obj)

#SCZ&BPvsCO
swe_filtered_HIST1H2AD_GJC1.Bed = "./swe_filtered_HIST1H2AD_GJC1.bed"
swe_filtered_HIST1H2AD_GJC1.Bim = "./swe_filtered_HIST1H2AD_GJC1.bim"
swe_filtered_HIST1H2AD_GJC1.Fam = "./swe_filtered_HIST1H2AD_GJC1.fam"
swe_filtered_HIST1H2AD_GJC1.SetID = "./swe_HIST1H2AD_GJC1_SNPset_ID"
swe_filtered_HIST1H2AD_GJC1.SSD = "./swe_filtered_HIST1H2AD_GJC1.SSD"
swe_filtered_HIST1H2AD_GJC1.Info = "./swe_filtered_HIST1H2AD_GJC1.Info"
swe_filtered_HIST1H2AD_GJC1.Cov = "./swe_filtered_HIST1H2AD_GJC1.cov"

Generate_SSD_SetID(swe_filtered_HIST1H2AD_GJC1.Bed, swe_filtered_HIST1H2AD_GJC1.Bim, swe_filtered_HIST1H2AD_GJC1.Fam, swe_filtered_HIST1H2AD_GJC1.SetID, swe_filtered_HIST1H2AD_GJC1.SSD, swe_filtered_HIST1H2AD_GJC1.Info)

FAM = Read_Plink_FAM(swe_filtered_HIST1H2AD_GJC1.Fam, Is.binary=FALSE)
y = FAM$Phenotype
y = y - 1
SSD.INFO = Open_SSD(swe_filtered_HIST1H2AD_GJC1.SSD, swe_filtered_HIST1H2AD_GJC1.Info)

obj = SKAT_Null_Model(y ~ 1, out_type = "D")
out = SKAT.SSD.All(SSD.INFO, obj)

swe_filtered_HIST1H2AD_GJC1_Cov = Read_Plink_FAM_Cov(swe_filtered_HIST1H2AD_GJC1.Fam, swe_filtered_HIST1H2AD_GJC1.Cov, Is.binary = TRUE)
X1 = swe_filtered_HIST1H2AD_GJC1_Cov$Sex.y
obj = SKAT_Null_Model(y ~ X1, out_type = "D")
out = SKAT.SSD.All(SSD.INFO,obj)