process selectVariants {
    tag "${cohort_name}"
    publishDir "${params.output_dir}/selectVariants", mode: 'symlink'

    input:
    path vcf

    output:
    tuple val(cohort_name), path "${cohort_name}.snps.vcf.gz",     emit: snps
    tuple val(cohort_name), path "${cohort_name}.indels.vcf.gz",   emit: indels

    script:
    """
    gatk SelectVariants \
    -V ${vcf} \
    -select-type SNP \
    -O ${cohort_name}.snps.vcf.gz

    gatk SelectVariants \
    -V ${vcf} \
    -select-type INDEL \
    -O ${cohort_name}.indels.vcf.gz
    """

    stub:
    """
    sleep 40
    touch ${vcf.baseName}.snps.vcf.gz
    touch ${vcf.baseName}.indels.vcf.gz
    """
}