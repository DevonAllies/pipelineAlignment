process GENOMICSDB {
    tag "$cohort_name"
    publishDir "${params.outdir}/genomicsdb", mode: 'symlink'

    input:
    path all_gvcfs
    path all_gvcfsidxs
    params.cohort_name

    output:
    path "${cohort_name}_gdb"
    
    script:
    def gvcfs_line = all_gvcfs.collect { gvcf -> "-V ${gvcf}" }.join(" ")
    """
    gatk GenomicsDBImport \
    -V ${all_gvcfs} \
    --genomicsdb-workspace-path ${cohort_name}_gdb \
    --intervals 1 \
    --intervals 2 \
    --intervals 3 \
    --intervals 4 \
    --intervals 5 \
    --intervals 6 \
    --intervals 7 \
    --intervals 8 \
    --intervals 9 \
    --intervals 10 \
    --intervals 11 \
    --intervals 12 \
    --intervals 13 \
    --intervals 14 \
    --intervals 15 \
    --intervals 16 \
    --intervals 17 \
    --intervals 18 \
    --intervals 19 \
    --intervals 20 \
    --intervals 21 \
    --intervals 22 \
    --intervals chrX \
    --intervals chrY
    """

    stub:
    """
    sleep 40
    touch ${cohort_name}.vcf.gz ${cohort_name}.vcf.gz.tbi
    """
}