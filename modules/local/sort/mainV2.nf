process SORT_BAM {

	tag "${sampleId}"
	publishDir "${params.outdir}/sorted", mode: 'symlink'

	input:
	tuple val(sampleId), path(bam)

	output:
	tuple val(sampleId), path("${sampleId}.sorted.bam"), emit: sorted_bam

	script:
	"""
	samtools sort -o ${sampleId}.sorted.bam ${bam}
	"""

	stub:
	"""
	touch ${sampleId}.sorted.bam
	"""
}
