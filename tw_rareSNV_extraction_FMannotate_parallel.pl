#!/usr/bin/perl -w
use Parallel::ForkManager;
@chrs = (1..22,"X");
#@chrs = (20..22);
#$p = 0;
my $pm = Parallel::ForkManager->new(5);

open $trio_fh,'<',"/data1_3/sjiang4/denovo/tw_triolist_all.csv";
@trio_array = <$trio_fh>;
$n = 0;
for (0..$#trio_array) {
@line = split /,/, $trio_array[$n];
$trio = $line[0] . '_' . $line[1];
push @trios, $trio;
$n++;
}

$p = 0;
for (0..$#trios) {
CHR_LOOP:
foreach $chr(@chrs) {
$pm->start and next CHR_LOOP;

open $chr_fh,'<',"/data1_3/sjiang4/gnomad/gnomad_genomes_chr${chr}_rare_variant0.01.vcf";
@chr_array = <$chr_fh>;
$n = 2;
for (2..$#chr_array) {
@line = split /\t/, $chr_array[$n];
push @chr_matrix, [@line];
$n++;
}

#system("vcftools --vcf /data1/sjiang4/denovo/jointcall_trio/dnm_vcf/phase/fam35_02451_trio1.pass.phase.fd.vcf --chr $chr --recode --out /data1_3/sjiang4/rareSNV/test/fam35_02451_trio1.chr$chr.pass.phase.fd");
###extract chr.vcf
open $in_fh,'<',"/data1/sjiang4/denovo/jointcall_trio/dnm_vcf/phase/$trios[$p].pass.phase.fd.vcf";
open $out_fh,'>',"/data1_3/sjiang4/rareSNV/$trios[$p].chr$chr.pass.phase.fd.vcf";
@in_array = <$in_fh>;
$n = 0;
for (0..$#in_array) {
if ($in_array[$n] =~ m/\A#/) {
print $out_fh "$in_array[$n]";
$n++;
next;
}
if ($in_array[$n] =~ m/\A$chr\t/) {
print $out_fh "$in_array[$n]";
}
$n++;
}
close $in_fh;
close $out_fh;

open $in_fh,'<',"/data1_3/sjiang4/rareSNV/$trios[$p].chr$chr.pass.phase.fd.vcf";
open $out_fh,'>',"/data1_3/sjiang4/rareSNV/$trios[$p].chr$chr.rareSNV.vcf";
@in_array = <$in_fh>;
$n = 0;
$m = 2;
for (0..$#in_array) {
if ($in_array[$n] =~ m/\A#/) {
print $out_fh "$in_array[$n]";
$n++;
next;
}
chomp($in_array[$n]);
@line = split /\t/, $in_array[$n];
##chr
#if ($line[0] =~ m/\A1\z/) {
#$m = 0;
for ($m..$#chr_array) {
if ($chr_matrix[$m][1] > $line[1]) {
last;
}
if ($line[1] == $chr_matrix[$m][1]) {
###gnomad_ref match sample_ref
if ($line[3] =~ m/\A$chr_matrix[$m][3]\z/) {
#if ($line[4] =~ m/\A$chr_matrix[$m][4],/ || $line[4] =~ m/,$chr_matrix[$m][4],/ || $line[4] =~ m/,$chr_matrix[$m][4]\z/) {
if (($line[9] =~ m/\A$chr_matrix[$m][4]\|/ || $line[9] =~ m/\|$chr_matrix[$m][4]:/) && $line[11] =~ m/\A$chr_matrix[$m][4]\|/ && $line[11] !~ m/\|$chr_matrix[$m][4]:/) {
print $out_fh "$in_array[$n]\tF\n";
last;
}
if (($line[10] =~ m/\A$chr_matrix[$m][4]\|/ || $line[10] =~ m/\|$chr_matrix[$m][4]:/) && $line[11] !~ m/\A$chr_matrix[$m][4]\|/ && $line[11] =~ m/\|$chr_matrix[$m][4]:/) {
print $out_fh "$in_array[$n]\tM\n";
last;
}
if (($line[9] =~ m/\A$chr_matrix[$m][4]\|/ || $line[9] =~ m/\|$chr_matrix[$m][4]:/) && ($line[10] =~ m/\A$chr_matrix[$m][4]\|/ || $line[10] =~ m/\|$chr_matrix[$m][4]:/) && ($line[11] =~ m/\A$chr_matrix[$m][4]\|/ && $line[11] =~ m/\|$chr_matrix[$m][4]:/)) {
print $out_fh "$in_array[$n]\tFM\n";
last;
}
#}
}
###gnomad_alt match sample_ref
if ($line[3] =~ m/\A$chr_matrix[$m][4]\z/ && ($line[4] =~ m/\A$chr_matrix[$m][3],/ || $line[4] =~ m/,$chr_matrix[$m][3],/ || $line[4] =~ m/,$chr_matrix[$m][3]\z/) && length($chr_matrix[$m][3]) == 1 && length($chr_matrix[$m][4]) == 1) {
#if ($line[4] =~ m/\A$chr_matrix[$m][3],/ || $line[4] =~ m/,$chr_matrix[$m][3],/ || $line[4] =~ m/,$chr_matrix[$m][3]\z/) {
if (($line[9] =~ m/\A$chr_matrix[$m][4]\|/ || $line[9] =~ m/\|$chr_matrix[$m][4]:/) && $line[11] =~ m/\A$chr_matrix[$m][4]\|/ && $line[11] !~ m/\|$chr_matrix[$m][4]:/) {
print $out_fh "$in_array[$n]\tF\n";
last;
}
if (($line[10] =~ m/\A$chr_matrix[$m][4]\|/ || $line[10] =~ m/\|$chr_matrix[$m][4]:/) && $line[11] !~ m/\A$chr_matrix[$m][4]\|/ && $line[11] =~ m/\|$chr_matrix[$m][4]:/) {
print $out_fh "$in_array[$n]\tM\n";
last;
}
if (($line[9] =~ m/\A$chr_matrix[$m][4]\|/ || $line[9] =~ m/\|$chr_matrix[$m][4]:/) && ($line[10] =~ m/\A$chr_matrix[$m][4]\|/ || $line[10] =~ m/\|$chr_matrix[$m][4]:/) && ($line[11] =~ m/\A$chr_matrix[$m][4]\|/ && $line[11] =~ m/\|$chr_matrix[$m][4]:/)) {
print $out_fh "$in_array[$n]\tFM\n";
last;
}
}
}
$m++;
}
#}
$n++;
}
close $in_fh;
close $out_fh;

$pm->finish;
}
$pm->wait_all_children;

###rareSNV_vcf_combination
open $in_fh,'<',"/data1/sjiang4/denovo/jointcall_trio/dnm_vcf/phase/$trios[$p].pass.phase.fd.vcf";
open $out_fh,'>',"/data1_3/sjiang4/rareSNV/$trios[$p].rareSNV.vcf";
@in_array = <$in_fh>;
$n = 0;
for (0..$#in_array) {
if ($in_array[$n] =~ m/\A#/) {
print $out_fh "$in_array[$n]";
$n++;
next;
}
if ($in_array[$n] !~ m/\A#/) {
last;
}
}
close $in_fh;

$n = 0;
for (0..$#chrs) {
open $in_fh,'<',"/data1_3/sjiang4/rareSNV/$trios[$p].chr$chrs[$n].rareSNV.vcf";
@in_array = <$in_fh>;
$m = 0;
for (0..$#in_array) {
if ($in_array[$m] !~ m/\A#/) {
print $out_fh "$in_array[$m]";
}
$m++;
}
close $in_fh;
$n++;
}
system("rm /data1_3/sjiang4/rareSNV/$trios[$p].chr*.rareSNV.vcf");
system("rm /data1_3/sjiang4/rareSNV/$trios[$p].chr*.pass.phase.fd.vcf");
$p++;
}