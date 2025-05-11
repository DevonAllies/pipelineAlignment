process markDuplicates {
    tag "${sampleId}"
    publishDir "${params.outdir}/marked", mode: 'symlink'

    input:
    tuple val(sampleId), path(sorted_bam)

    output:
    tuple val(sampleId), path("${sampleId}.marked.bam"), emit: marked_bam

    script:
    """
   java -jar /apps/chpc/bio/picard/3.0.0/picard.jar MarkDuplicates \
   I=${sorted_bam} \
   O=${sampleId}.marked.bam \
   M=${sampleId}.marked.bam.metrics.txt
    """
    stub:
    """
    touch ${sampleId}.marked.bam
    """
}