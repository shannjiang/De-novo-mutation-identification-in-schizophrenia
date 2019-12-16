#!/usr/bin/perl -w
open $swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_fh,'<',"/collab2/CPH/sjiang4/scz_sweden_wes/v2/sub/sub20160809/swe_filtered_BP_removed_HIST1H2AD_GJC1.bim";
@swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_array = <$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_fh>;
$n = 0;
for (0..$#swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_array) {
chomp($swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_array[$n]);
@line = split /\t/, $swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_array[$n];
push @swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix, [@line];
$n++;
}

$HIST1H2AD_SCZ_rare_variant_count = 0;
$HIST1H2AD_CO_rare_variant_count = 0;
$GJC1_SCZ_rare_variant_count = 0;
$GJC1_CO_rare_variant_count = 0;
open $swe_filtered_BP_removed_HIST1H2AD_GJC1_ped_fh,'<',"/collab2/CPH/sjiang4/scz_sweden_wes/v2/sub/sub20160809/swe_filtered_BP_removed_HIST1H2AD_GJC1_ped.ped";
@swe_filtered_BP_removed_HIST1H2AD_GJC1_ped_array = <$swe_filtered_BP_removed_HIST1H2AD_GJC1_ped_fh>;
$n = 0;
for (0..$#swe_filtered_BP_removed_HIST1H2AD_GJC1_ped_array) {
chomp($swe_filtered_BP_removed_HIST1H2AD_GJC1_ped_array[$n]);
@line = split / /, $swe_filtered_BP_removed_HIST1H2AD_GJC1_ped_array[$n];
if ($line[5] == 1) {
$m = 0;
for (0..$#swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_array) {
if ($swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][0] == 6) {
if ($line[$m*2+6] =~ m/\A$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][4]\z/) {
$HIST1H2AD_CO_rare_variant_count++;
}
if ($line[$m*2+7] =~ m/\A$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][4]\z/) {
$HIST1H2AD_CO_rare_variant_count++;
}
}

if ($swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][0] == 17) {
if ($line[$m*2+6] =~ m/\A$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][4]\z/) {
$GJC1_CO_rare_variant_count++;
}
if ($line[$m*2+7] =~ m/\A$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][4]\z/) {
$GJC1_CO_rare_variant_count++;
}
}
$m++;
}
}

if ($line[5] == 2) {
$m = 0;
for (0..$#swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_array) {
if ($swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][0] == 6) {
if ($line[$m*2+6] =~ m/\A$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][4]\z/) {
$HIST1H2AD_SCZ_rare_variant_count++;
}
if ($line[$m*2+7] =~ m/\A$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][4]\z/) {
$HIST1H2AD_SCZ_rare_variant_count++;
}
}

if ($swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][0] == 17) {
if ($line[$m*2+6] =~ m/\A$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][4]\z/) {
$GJC1_SCZ_rare_variant_count++;
}
if ($line[$m*2+7] =~ m/\A$swe_filtered_BP_removed_HIST1H2AD_GJC1_bim_matrix[$m][4]\z/) {
$GJC1_SCZ_rare_variant_count++;
}
}
$m++;
}
}

$n++;
}

open $out_fh,'>',"swe_SCZvsCO_HIST1H2AD_GJC1_rare_variant_count_summary";
print $out_fh "HIST1H2AD_SCZ_rare_variant_count\t$HIST1H2AD_SCZ_rare_variant_count\nHIST1H2AD_CO_rare_variant_count\t$HIST1H2AD_CO_rare_variant_count\nGJC1_SCZ_rare_variant_count\t$GJC1_SCZ_rare_variant_count\nGJC1_CO_rare_variant_count\t$GJC1_SCZ_rare_variant_count";
