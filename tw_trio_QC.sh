for k in {1..24}
do
###loop code
IFS=',' read -r -a trio_info <<< $(sed "$[k]q;d" /data1_3/sjiang4/denovo/tw_triolist_all.csv)
sid=("${trio_info[@]:2:3}")
sidpath=("${trio_info[@]:5:3}")

/data1/sjiang4/soft/gatk-4.0.12.0/gatk VariantFiltration -R /data1/sjiang4/gatk_ref/human_g1k_v37_decoy.fasta --filter-expression "QD < 2.0" --filter-name VarConFilter --filter-expression "MQ < 40.0" --filter-name RMS_MQFilter --filter-expression "FS > 60.0" --filter-name StrandBiasFilter --cluster-window-size 10 --cluster-size 3 --variant /data1/sjiang4/denovo/jointcall_trio/${trio_info[0]}_${trio_info[1]}.vcf.gz --output /data1/sjiang4/denovo/jointcall_trio/filter/${trio_info[0]}_${trio_info[1]}.filter.vcf &

done

wait

for k in {1..24}
do
###loop code
IFS=',' read -r -a trio_info <<< $(sed "$[k]q;d" /data1_3/sjiang4/denovo/tw_triolist_all.csv)
sid=("${trio_info[@]:2:3}")
sidpath=("${trio_info[@]:5:3}")

vcftools --vcf /data1/sjiang4/denovo/jointcall_trio/filter/${trio_info[0]}_${trio_info[1]}.filter.vcf --remove-filtered-all --recode --out /data1/sjiang4/denovo/jointcall_trio/pass/${trio_info[0]}_${trio_info[1]}.pass.vcf &
done
