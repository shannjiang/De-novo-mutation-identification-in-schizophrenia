#!/usr/bin/perl -w
open $tw_sampleID_fh,'<',"/data1_3/sjiang4/denovo/tw_triolist_all.csv";
@sampleIDarray = <$tw_sampleID_fh>;
$i = 0;
for (0..$#sampleIDarray) {
@line = split /,/, $sampleIDarray[$i];
push @sampleIDmatrix, [@line];
@line = ();
$i++;
}
$m = 0;
for (0..$#sampleIDarray) {

system("vcftools --vcf /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_mr1e8_autotune_final/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_point_lowmaf.mr1e8.fd.vcf --indv $sampleIDmatrix[$m][4] --recode --out /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_$sampleIDmatrix[$m][4]_point_DNM");

system("/data1/sjiang4/soft/annovar/convert2annovar.pl -format vcf4old /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_$sampleIDmatrix[$m][4]_point_DNM.recode.vcf > /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_$sampleIDmatrix[$m][4]_point_DNM.avinput");

system("/data1/sjiang4/soft/annovar/table_annovar.pl /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_$sampleIDmatrix[$m][4]_point_DNM.avinput /data1/sjiang4/soft/annovar/humandb/ -buildver hg19 -out /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_point_DNM -remove -protocol refGene,cytoBand,gnomad_exome,gnomad_genome,exac03,EAS.sites.2015_08,popfreq_all_20150413,avsnp150,ljb26_all -operation gx,r,f,f,f,f,f,f,f -nastring . -csvout -polish");

system("vcftools --vcf /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_mr1e8_autotune_final/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_indel_lowmaf.mr1e8.fd.vcf --indv $sampleIDmatrix[$m][4] --recode --out /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_$sampleIDmatrix[$m][4]_indel_DNM");

system("/data1/sjiang4/soft/annovar/convert2annovar.pl -format vcf4old /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_$sampleIDmatrix[$m][4]_indel_DNM.recode.vcf > /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_$sampleIDmatrix[$m][4]_indel_DNM.avinput");

system("/data1/sjiang4/soft/annovar/table_annovar.pl /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_$sampleIDmatrix[$m][4]_indel_DNM.avinput /data1/sjiang4/soft/annovar/humandb/ -buildver hg19 -out /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_annovar/$sampleIDmatrix[$m][0]_$sampleIDmatrix[$m][1]_indel_DNM -remove -protocol refGene,cytoBand,gnomad_exome,gnomad_genome,exac03,EAS.sites.2015_08,popfreq_all_20150413,avsnp150,ljb26_all -operation gx,r,f,f,f,f,f,f,f -nastring . -csvout -polish");

$m++;
}