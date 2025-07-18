process ALIGN {

	tag "$sampleId"
	publishDir "${params.outdir}/aligned", mode: 'symlink'

	input:
	tuple val(sampleId), path(read1), path(read2)
	path reference_dir // The index files that is required is not the fai file but the files generated from bwa index
		
	output:
	tuple val(sampleId), path("${sampleId}.sam"), emit: sam

	script:
	"""
	bwa mem -t ${task.cpus} \
	-R "@RG\\tID:${sampleId}\\tSM:${sampleId}\\tLB:lib1\\tPL:MGI\\tPU:unit1" \
	${reference_dir}/sac.fa \
	${read1} \
	${read2} \
	> "${sampleId}.sam"
	"""

	stub:
	"""
	touch "${sampleId}.sam"
	"""
}
