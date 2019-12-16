#!/usr/bin/perl -w
#use File::CountLines qw(count_lines);
open $sampleID_fh,'<',"/data1_3/sjiang4/denovo/tw_triolist_all.csv";
@sampleID_array = <$sampleID_fh>;
$i = 0;
for (0..$#sampleID_array) {
@line = split /,/, $sampleID_array[$i];
push @sampleID_matrix, [@line];
$i++;
}

$i = 0;
for (0..$#sampleID_array) {
$j = 0;
for (0..2000) {
open $in_fh,'<',"/data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNM_mr1e8/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_indel_lowmaf.vcf";
open $out_fh,'>',"/data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_indel_lowmaf.mr1e8.fd.vcf";
#open $in_fh,'<',"/data1/sjiang4/denovo/jointcall_trio/3tools_overlap_DNM_mr1e8/fam35_02451_trio1.chr1-22XY.mr1e8.recode.vcf";
#open $out_fh,'>',"/data1/sjiang4/denovo/jointcall_trio/3tools_overlap_DNMfd_mr1e8_autotune/fam35_02451_trio1_mr1e8.fd.vcf";
@in_array = <$in_fh>;
$k = 0;
for (0..$#in_array) {
if ($in_array[$k] =~ m/\A#/) {
print $out_fh "$in_array[$k]";
} else {
@F = split /\t/, $in_array[$k];
if ($F[5] >= 30) {
if ($F[9] =~ /([0-9])\/([0-9])/) {
if ($1 eq $2 && $F[10] =~ m/$1\/$1/) {
if ($F[11] =~ /([0-9])\/([0-9])/) {
if ($1 ne $2) {
if ($F[11] =~ /(\d+),(\d+),(\d+)/) {
if ($1 > $j && $2 == 0 && $3 > $j) {
print $out_fh "$in_array[$k]";
}
}
}
}
}
}
}
}
$k++;
}

#system("less /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_DNM_mr1e8/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1].chr1-22XY.mr1e8.recode.vcf | perl -lane 'print if /#/; next if length($F[3])>1 || length($F[4])>1 || $F[4]=~/,/; next if $F[5]<30; $F[9] =~ /([0-9])\/([0-9])/; next if $1 ne $2; next if $F[10] !~ /$1\/$1/; $F[11]=~/([0-9])\/([0-9])/; next if $1 eq $2; $F[11] =~ /(\d+),(\d+),(\d+)/; next if $2 != 0 || $1<$j || $3<$j; print' | less > /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_mr1e8.fd.vcf");
system("cat /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_indel_lowmaf.mr1e8.fd.vcf | wc -l > /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_indel_lowmaf.linecount");
open $file_fh,'<',"/data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_indel_lowmaf.linecount";
@file_array = <$file_fh>;
chomp($file_array[0]);
#print "$file_array[0] ";
#system("cat /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1].linecount");
#print "$counts\n";
#my $count = count_lines("/data1/sjiang4/denovo/jointcall_trio/3tools_overlap_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_mr1e8.fd.vcf");
#$count = qx[cat /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_mr1e8.fd.vcf | wc -l];
#$count = $count + 55;
#print "$count\n";
if ($file_array[0] <= 132) {
system("cp /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_mr1e8_autotune/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_indel_lowmaf.mr1e8.fd.vcf /data1/sjiang4/denovo/jointcall_trio/3tools_overlap_lowmaf_DNMfd_mr1e8_autotune_final/$sampleID_matrix[$i][0]_$sampleID_matrix[$i][1]_indel_lowmaf.mr1e8.fd.vcf");
close $in_fh;
close $out_fh;
last;
}
close $in_fh;
close $out_fh;
$j = $j + 10;
}
$i++;
}
#$i++;
#}
