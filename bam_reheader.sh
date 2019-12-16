#!/bin/bash
mapfile -t sampleID < /home/sjiang4/tw_bam_reheader_test

for i in {0..1}
do
  samtools view -H /data1_2/ywang59/Schizophenia_Bamfile/${sampleID[$i]}_recal_reads.bam > ${sampleID[$i]}_header.sam
  sed -i "s/SM:20/SM:${sampleID[$i]}/" ${sampleID[$i]}_header.sam
  samtools reheader ${sampleID[$i]}_header.sam ${sampleID[$i]}_recal_reads.bam > ${sampleID[$i]}.bam
  rm ${sampleID[$i]}_header.sam
  #rm ${sampleID[$i]}_recal_reads.bam
done
