#!/usr/bin/perl -w
open $DNMgene_body_coordinate_fh,'<',"/data1/sjiang4/annotation/DNMgene_annotation/DNM_gene_body_coordinate.csv";
@DNMgene_body_coordinate_array = <$DNMgene_body_coordinate_fh>;
$n = 1;
for (1..$#DNMgene_body_coordinate_array) {
chomp($DNMgene_body_coordinate_array[$n]);
@line = split /,/, $DNMgene_body_coordinate_array[$n];
push @DNMgene_body_coordinate_matrix, [@line];
$n++;
}
open $DNMgene_PEC_enhancer_coordinate_fh,'<',"/data1/sjiang4/annotation/DNMgene_annotation/DNMgenes_PEC_enhancers_nopromoter.csv";
@DNMgene_PEC_enhancer_coordinate_array = <$DNMgene_PEC_enhancer_coordinate_fh>;
$n = 1;
for (1..$#DNMgene_PEC_enhancer_coordinate_array) {
chomp($DNMgene_PEC_enhancer_coordinate_array[$n]);
@line = split /,|:|-/, $DNMgene_PEC_enhancer_coordinate_array[$n];
$line[2] =~ s/chr//;
push @DNMgene_PEC_enhancer_coordinate_matrix, [@line];
$n++;
}
open $DNMgene_PEC_HiC_enhancer_coordinate_fh,'<',"/data1/sjiang4/annotation/DNMgene_annotation/DNMgenes_PEC_HiC_enhancers.csv";
@DNMgene_PEC_HiC_enhancer_coordinate_array = <$DNMgene_PEC_HiC_enhancer_coordinate_fh>;
$n = 1;
for (1..$#DNMgene_PEC_HiC_enhancer_coordinate_array) {
chomp($DNMgene_PEC_HiC_enhancer_coordinate_array[$n]);
@line = split /,/, $DNMgene_PEC_HiC_enhancer_coordinate_array[$n];
$line[0] =~ s/chr//;
push @DNMgene_PEC_HiC_enhancer_coordinate_matrix, [@line];
$n++;
}
open $DNMgene_promoter_coordinate_fh,'<',"/data1/sjiang4/annotation/DNMgene_annotation/DNMgenes_promoters.bed";
@DNMgene_promoter_coordinate_array = <$DNMgene_promoter_coordinate_fh>;
$n = 0;
for (0..$#DNMgene_promoter_coordinate_array) {
chomp($DNMgene_promoter_coordinate_array[$n]);
@line = split /\t/, $DNMgene_promoter_coordinate_array[$n];
$line[0] =~ s/chr//;
push @DNMgene_promoter_coordinate_matrix, [@line];
$n++;
}
use Parallel::ForkManager;
my $pm = Parallel::ForkManager->new(10);
open $tw_tdn_files_fh,'<',"/data1/sjiang4/denovo/jointcall_trio/tdn_mr1e8_output/tw_tdn.list";
@tw_tdn_files = <$tw_tdn_files_fh>;

TW_TDN_FILE_LOOP:
foreach $tw_tdn_file(@tw_tdn_files) {
$pm->start and next TW_TDN_FILE_LOOP;
chomp($tw_tdn_file);
open $tw_tdn_file_fh,'<',"/data1/sjiang4/denovo/jointcall_trio/tdn_mr1e8_output/${tw_tdn_file}_tdnout.vcf";
@tw_tdn_file_array = <$tw_tdn_file_fh>;
#$tw_tdn_file =~ s/_fd.vcf//;

open $DNMgene_body_fh,'>',"/data1/sjiang4/denovo/jointcall_trio/tdn_mr1e8_output/DNMgene_DNMs/${tw_tdn_file}_DNMgene_body_DNMs.vcf";
print $DNMgene_body_fh "$tw_tdn_file_array[13]";
$n = 14;
for (14..$#tw_tdn_file_array) {
chomp($tw_tdn_file_array[$n]);
@line = split /\t/, $tw_tdn_file_array[$n];
$m = 0;
for (1..$#DNMgene_body_coordinate_array) {
if ($line[0] =~ m/\A$DNMgene_body_coordinate_matrix[$m][1]\z/ and $line[1] >= $DNMgene_body_coordinate_matrix[$m][2] and $line[1] <= $DNMgene_body_coordinate_matrix[$m][3]) {
print $DNMgene_body_fh "$tw_tdn_file_array[$n]\t$DNMgene_body_coordinate_matrix[$m][0]\n";
}
$m++;
}
$n++;
}

open $DNMgene_PEC_enhancer_fh,'>',"/data1/sjiang4/denovo/jointcall_trio/tdn_mr1e8_output/DNMgene_DNMs/${tw_tdn_file}_DNMgene_enhancer.vcf";
print $DNMgene_PEC_enhancer_fh "$tw_tdn_file_array[13]";
$n = 14;
for (14..$#tw_tdn_file_array) {
chomp($tw_tdn_file_array[$n]);
@line = split /\t/, $tw_tdn_file_array[$n];
$m = 0;
for (1..$#DNMgene_PEC_enhancer_coordinate_array) {
if ($line[0] =~ m/\A$DNMgene_PEC_enhancer_coordinate_matrix[$m][2]\z/ and $line[1] >= $DNMgene_PEC_enhancer_coordinate_matrix[$m][3] and $line[1] <= $DNMgene_PEC_enhancer_coordinate_matrix[$m][4]) {
print $DNMgene_PEC_enhancer_fh "$tw_tdn_file_array[$n]\t$DNMgene_PEC_enhancer_coordinate_matrix[$m][1]\t$DNMgene_PEC_enhancer_coordinate_matrix[$m][0]\t$DNMgene_PEC_enhancer_coordinate_matrix[$m][5]\n";
}
$m++;
}
$n++;
}

open $DNMgene_PEC_HiC_enhancer_fh,'>',"/data1/sjiang4/denovo/jointcall_trio/tdn_mr1e8_output/DNMgene_DNMs/${tw_tdn_file}_DNMgene_HiC_enhancer.vcf";
print $DNMgene_PEC_HiC_enhancer_fh "$tw_tdn_file_array[13]";
$n = 14;
for (14..$#tw_tdn_file_array) {
chomp($tw_tdn_file_array[$n]);
@line = split /\t/, $tw_tdn_file_array[$n];
$m = 0;
for (1..$#DNMgene_PEC_HiC_enhancer_coordinate_array) {
if ($line[0] =~ m/\A$DNMgene_PEC_HiC_enhancer_coordinate_matrix[$m][0]\z/ and $line[1] >= $DNMgene_PEC_HiC_enhancer_coordinate_matrix[$m][1] and $line[1] <= $DNMgene_PEC_HiC_enhancer_coordinate_matrix[$m][2]) {
print $DNMgene_PEC_HiC_enhancer_fh "$tw_tdn_file_array[$n]\t$DNMgene_PEC_HiC_enhancer_coordinate_matrix[$m][8]\t$DNMgene_PEC_HiC_enhancer_coordinate_matrix[$m][3]\n";
}
$m++;
}
$n++;
}

open $DNMgene_promoter_fh,'>',"/data1/sjiang4/denovo/jointcall_trio/tdn_mr1e8_output/DNMgene_DNMs/${tw_tdn_file}_DNMgene_promoter.vcf";
print $DNMgene_promoter_fh "$tw_tdn_file_array[13]";
$n = 14;
for (14..$#tw_tdn_file_array) {
chomp($tw_tdn_file_array[$n]);
@line = split /\t/, $tw_tdn_file_array[$n];
$m = 0;
for (0..$#DNMgene_promoter_coordinate_array) {
if ($line[0] =~ m/\A$DNMgene_promoter_coordinate_matrix[$m][0]\z/ and $line[1] >= $DNMgene_promoter_coordinate_matrix[$m][1] and $line[1] <= $DNMgene_promoter_coordinate_matrix[$m][2]) {
print $DNMgene_promoter_fh "$tw_tdn_file_array[$n]\t$DNMgene_promoter_coordinate_matrix[$m][3]\n";
}
$m++;
}
$n++;
}
$pm->finish;
}