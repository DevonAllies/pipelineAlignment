process JOINTGENOTYPING {
    tag "$cohort_name"
    publishDir "${params.outdir}/jointgenotyping", mode: 'symlink'

    input:
    path all_gvcfs
    path all_idxs
    val cohort_name
    path reference_genome
    path reference_dict
    path reference_index

    output:
    path "${cohort_name}.joint.vcf",       emit: gvcf
    path "${cohort_name}.joint.vcf.idx",   emit: gidx
    
    script:
    def gvcfs_line = all_gvcfs.collect { gvcf -> "-V ${gvcf}" }.join(' ')
    """
    gatk GenomicsDBImport \
    ${gvcfs_line} \
    --genomicsdb-workspace-path ${cohort_name}_gdb \

    gatk GenotypeGVCFs \
    -R ${reference_genome} \
    -V gendb://${cohort_name}_gdb \
    -O ${cohort_name}.joint.vcf
    """

    stub:
    """
    sleep 40
    touch ${cohort_name}.vcf.gz ${cohort_name}.vcf.gz.tbi
    """
}