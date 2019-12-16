#!/usr/bin/perl -w
use Parallel::ForkManager;
@chrs = (1..22,"X","Y");
my $pm = Parallel::ForkManager->new(24);

CHR_LOOP:
foreach $chr(@chrs) {
$pm->start and next CHR_LOOP;

###sambamba slice
system("sambamba slice -o /data1_3/sjiang4/denovo/samtools/test/VCU01C06835_chr$chr.bam /data1_2/ywang59/SCZ_Reheader_Bamfile/VCU01C06835.bam $chr");
system("sambamba slice -o /data1_3/sjiang4/denovo/samtools/test/VCU01C06840_chr$chr.bam /data1_2/ywang59/SCZ_Reheader_Bamfile/VCU01C06840.bam $chr");
system("sambamba slice -o /data1_3/sjiang4/denovo/samtools/test/VCU01C06833_chr$chr.bam /data1_2/ywang59/SCZ_Reheader_Bamfile/VCU01C06833.bam $chr");

###samtools mpileup per chr
system("samtools mpileup -d 250 -m 1 -E --BCF --output-tags DP,AD,ADF,ADR,SP -f /data1/sjiang4/ucsc_ref/N_hg19.chr$chr.fasta -o /data1_3/sjiang4/denovo/samtools/test/fam35_02451_trio1_chr$chr.bcf /data1_3/sjiang4/denovo/samtools/test/VCU01C06835_chr$chr.bam /data1_3/sjiang4/denovo/samtools/test/VCU01C06840_chr$chr.bam /data1_3/sjiang4/denovo/samtools/test/VCU01C06833_chr$chr.bam");

$pm->finish;
}
$pm->wait_all_children;
