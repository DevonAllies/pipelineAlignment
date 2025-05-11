process INDEX_BAM {

	tag "${sampleId}"
	publishDir "${params.outdir}/sorted", mode: 'symlink'
	
	input:
	tuple val(sampleId), path(marked_bam)

	output:
	tuple val(sampleId), path(marked_bam), path("${marked_bam}.bai"), emit: marked_bam_index

	script:
	"""
	samtools index ${marked_bam}
	"""

	stub:
	"""
	touch ${marked_bam}.bai
	"""
}
