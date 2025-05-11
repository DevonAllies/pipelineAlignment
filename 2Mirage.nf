#!/usr/bin/env nextflow

// Import modules

include { JOINTGENOTYPING }     from "${projectDir}/modules/local/jointgenotyping/main2.nf"
include { selectVariants }      from "${projectDir}/modules/local/selectVariants/main.nf"
include { VARIANT_FILTERING }   from "${projectDir}/modules/local/vqsr/main.nf"

// Main workflows

workflow {

    // Collect all GVCFs from directory
    all_gvcfs_ch    =  Channel.fromPath(params.vcf_dir).glob ('*.g.vcf')
    all_idx_ch      =  Channel.fromPath(params.vcf_dir).glob ('*.g.vcf.idx')

    reference_ch        = file(params.reference_genome)
    reference_dict_ch   = file(params.reference_dict)
    reference_index_ch  = file(params.reference_index)
    hg38_ch             = file(params.hg38)
    hg38_index_ch       = file(params.hg38_index)
    hg38_dict_ch        = file(params.hg38_dict)
    dbsnp_ch            = file(params.dbsnp)
    dbsnp_index_ch      = file(params.dbsnp_index)
    mills_ch            = file(params.mills)
    mills_index_ch      = file(params.mills_index)
    hapmap_ch           = file(params.hapmap)
    hapmap_index_ch     = file(params.hapmap_index)
    omni_ch             = file(params.omni)
    omni_index_ch       = file(params.omni_index)
    chromosome_list_ch  = file(params.chromosome_list)

    
    joint_called_vcf = JOINTGENOTYPING(
        all_gvcfs_ch,
        all_idx_ch,
        params.cohort_name,
        reference_ch,
        reference_index_ch,
        reference_dict_ch
    )

    select_variants = selectVariants(joint_called_vcf.vcf)
    
    // Variant Filtering
    VARIANT_FILTERING(
        select_variants.snps,
        select_variants.indels,
        reference_ch,
        reference_dict_ch,
        dbsnp_ch,
        mills_ch,
        hapmap_ch,
        omni_ch,
        dbsnp_index_ch,
        hapmap_index_ch,
        omni_index_ch,
        mills_index_ch
    )
}