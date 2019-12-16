for k in {1..24}
do
###loop code
IFS=',' read -r -a trio_info <<< $(sed "$[k]q;d" /data1_3/sjiang4/denovo/tw_triolist_all.csv)
sid=("${trio_info[@]:2:3}")
sidpath=("${trio_info[@]:5:3}")

###generate ped file for tdn
IFS=' ' read -r -a vcfsid <<< $(grep "#CHROM" /data1/sjiang4/denovo/jointcall_trio/pass/${trio_info[0]}_${trio_info[1]}.vcf)
printf "${trio_info[0]}\t${vcfsid[9]}\t0\t0\t1\t${vcfsid[9]}\n${trio_info[0]}\t${vcfsid[10]}\t0\t0\t2\t${vcfsid[10]}\n${trio_info[0]}\t${vcfsid[11]}\t${vcfsid[9]}\t${vcfsid[10]}\t${trio_info[8]}\t${vcfsid[11]}\n" > /data1/sjiang4/denovo/jointcall_trio/ped/${trio_info[0]}_${trio_info[1]}.ped &

done

wait

for k in {1..24}
do
###loop code
IFS=',' read -r -a trio_info <<< $(sed "$[k]q;d" /data1_3/sjiang4/denovo/tw_triolist_all.csv)
sid=("${trio_info[@]:2:3}")
sidpath=("${trio_info[@]:5:3}")

###dng
/usr/local/bin/dng dnm auto --ped /data1/sjiang4/denovo/jointcall_trio/ped/${trio_info[0]}_${trio_info[1]}.ped --vcf /data1/sjiang4/denovo/jointcall_trio/pass/${trio_info[0]}_${trio_info[1]}.pass.vcf -s 1.0e-08 --write /data1/sjiang4/denovo/jointcall_trio/dng_mr1e8_output/${trio_info[0]}_${trio_info[1]}_dngout.vcf &

done

wait

for k in {1..24}
do
###loop code
IFS=',' read -r -a trio_info <<< $(sed "$[k]q;d" /data1_3/sjiang4/denovo/tw_triolist_all.csv)
sid=("${trio_info[@]:2:3}")
sidpath=("${trio_info[@]:5:3}")
###triodenovo dnm calling
triodenovo --ped /data1/sjiang4/denovo/jointcall_trio/ped/${trio_info[0]}_${trio_info[1]}.ped --in_vcf /data1/sjiang4/denovo/jointcall_trio/pass/${trio_info[0]}_${trio_info[1]}.vcf --mu 1.0e-08 --out_vcf /data1/sjiang4/denovo/jointcall_trio/tdn_mr1e8_output/${trio_info[0]}_${trio_info[1]}_tdnout.vcf &

done

wait

for k in {1..24}
do
###loop code
IFS=',' read -r -a trio_info <<< $(sed "$[k]q;d" /data1_3/sjiang4/denovo/tw_triolist_all.csv)
sid=("${trio_info[@]:2:3}")
sidpath=("${trio_info[@]:5:3}")
###PhaseByTransmission dnm calling
java -jar /data1/sjiang4/soft/GenomeAnalysisTK-3.8-1-0/GenomeAnalysisTK.jar -T PhaseByTransmission -R /data1/sjiang4/gatk_ref/human_g1k_v37_decoy.fasta -V /data1/sjiang4/denovo/jointcall_trio/pass/${trio_info[0]}_${trio_info[1]}.vcf -ped /data1/sjiang4/denovo/jointcall_trio/ped/${trio_info[0]}_${trio_info[1]}.ped -prior 1.0e-8 -mvf /data1/sjiang4/denovo/jointcall_trio/pbt_mr1e8_output/${trio_info[0]}_${trio_info[1]}_pbtout.vcf &

done
