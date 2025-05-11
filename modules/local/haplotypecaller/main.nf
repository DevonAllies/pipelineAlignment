process HAPLOTYPECALLER {

	tag "$sampleId"
	publishDir "${params.outdir}/haplotypecaller", mode: "symlink"

	input:
	tuple val(sampleId), path(sorted_bam), path(sorted_bam_index)
	path reference_genome
	path reference_index
	path reference_dict

	output:
	tuple val(sampleId), path("${sampleId}.g.vcf"), 		emit: vcf
	tuple val(sampleId), path("${sampleId}.g.vcf.idx"), 	emit: idx

	script: 
	"""
	gatk HaplotypeCaller 
	-R ${reference_genome} \
	-I ${sorted_bam} \
	-O ${sampleId}.g.vcf \
	-ERC GVCF
	"""

	stub:
	"""
	sleep 22
	touch ${sampleId}.g.vcf
	touch ${sampleId}.g.vcf.idx
	"""
}