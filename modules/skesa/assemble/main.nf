process SKESA_ASSEMBLE {
    tag "$meta.id"
    label 'process_micro'

    module (params.enable_module ? "${params.swmodulepath}${params.fs}shovill${params.fs}2.5.1" : null)
    conda (params.enable_conda ? "bioconda::skesa=2.5.1 conda-forge::libgcc-ng" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/skesa:2.5.1--hdcf5f25_1' :
        'quay.io/biocontainers/skesa:2.5.1--hdcf5f25_1' }"

    input:
        tuple val(meta), path(reads)

    output:
        tuple val(meta), path("${prefix}.contigs.fa"), emit: assembly
        path "versions.yml"                          , emit: versions

    when:
        task.ext.when == null || task.ext.when

    script:
        def args = task.ext.args ?: ''
        def memory = (task.memory ? task.memory.toGiga() : 16)
        def all_reads = ("${params.fq_single_end}" ? "$reads" : "${reads[0]} ${reads[1]}")
        prefix = (task.ext.prefix ?: meta.id)
        """
        skesa \\
            $args \\
            --reads $all_reads \\
            --contigs_out ${prefix}.contigs.fa \\
            --cores $task.cpus \\
            --memory $memory

        cat <<-END_VERSIONS > versions.yml
        "${task.process}":
            skesa: \$(echo \$(skesa --version 2> /dev/null | grep -E -o 'SKESA .*' | sed 's/^SKESA //'))
        END_VERSIONS
        """
}