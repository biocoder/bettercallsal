process MEDAKA_CONSENSUS {
    tag "$meta.id"
    label 'process_low'

    module (params.enable_module ? "${params.swmodulepath}${params.fs}medaka${params.fs}1.11.2" : null)
    conda (params.enable_conda ? "bioconda::medaka=1.11.2 conda-forge::python" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/medaka:1.11.2--py310h87e71ce_0' :
        'quay.io/biocontainers/medaka:1.11.2--py310h87e71ce_0' }"

    input:
        tuple val(meta), path(bam), path(bai)

    output:
        tuple val(meta), path("*.hdr"), emit: hdr
        path "versions.yml"           , emit: versions

    when:
        task.ext.when == null || task.ext.when

    script:
        def args = task.ext.args ?: ''
        def prefix = task.ext.prefix ?: "${meta.id}"
        """
        medaka consensus \\
            --threads $task.cpus \\
            $args \\
            $bam \\
            ${prefix}.medaka.hdr

        cat <<-END_VERSIONS > versions.yml
        "${task.process}":
            medaka: \$( medaka --version 2> /dev/null | sed 's/medaka //g' )
        END_VERSIONS
        """
}