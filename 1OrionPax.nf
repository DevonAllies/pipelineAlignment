#!/usr/bin/env nextflow

// Import modules

include { ALIGN }               from "${projectDir}/modules/local/align/main.nf"
include { SAM_TO_BAM }          from "${projectDir}/modules/local/convert/mainV2.nf"
include { SORT_BAM }            from "${projectDir}/modules/local/sort/mainV2.nf"
include { markDuplicates }      from "${projectDir}/modules/local/markDuplicates/main.nf"
include { INDEX_BAM }           from "${projectDir}/modules/local/index/main.nf"
include { HAPLOTYPECALLER }     from "${projectDir}/modules/local/haplotypecaller/mainV2.nf"


// Main workflows

workflow {

    samples_ch = Channel
    .fromPath(params.csv)
    .splitCsv(header:true)
    .map { row -> tuple(row.sampleId, file(row.read1), file(row.read2)) }

    reference_dir_ch    = Channel.fromPath(params.reference_dir)
    reference_ch        = params.reference_genome
    reference_dict_ch   = params.reference_dict
    reference_index_ch  = params.reference_index
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

	// Alignment
	aligned_sams = ALIGN(samples_ch, reference_dir_ch)
	aligned_bams = SAM_TO_BAM(aligned_sams)
    sorted_bams = SORT_BAM(aligned_bams)
    marked_bams = markDuplicates(sorted_bams)
	indexed_bams = INDEX_BAM(marked_bams)

    // Variant Calling
     gvcfs = HAPLOTYPECALLER(
        marked_bams,
        reference_ch,
        reference_index_ch,
        reference_dict_ch
     )    

}
