// Help text for skesa within CPIPES.

def skesaHelp(params) {

    Map tool = [:]
    Map toolspecs = [:]
    tool.text = [:]
    tool.helpparams = [:]

    toolspecs = [
        'skesa_run': [
            clihelp: 'Run skesa tool. Default: ' +
                (params.skesa_run ?: false),
            cliflag: null,
            clivalue: null
        ],
        'skesa_hash_count': [
            clihelp: 'Use hash counter. ' +
                "Default: ${params.skesa_hash_count}",
            cliflag: '--hash_count',
            clivalue: (params.skesa_hash_count ? ' ' : '')
        ],
        'skesa_estimated_kmers': [
            clihelp: 'Estimated number of distinct kmers for bloom ' +
                'filter (millions, only for hash counter). ' +
                "Default: ${params.skesa_estimated_kmers}",
            cliflag: '--estimated_kmers',
            clivalue: (params.skesa_estimated_kmers ?: '')
        ],
        'skesa_skip_bloom_filter': [
            clihelp: "Don't do bloom filter; use --skesa_estimated_kmers as " +
                'the hash table size (only for hash counter). ' +
                "Default: ${params.skesa_skip_bloom_filter}",
            cliflag: '--skip_bloom_filter',
            clivalue: (params.skesa_skip_bloom_filter ? ' ' : '')
        ],
        'skesa_use_paired_reads': [
            clihelp: 'Indicates that single (not comma separated) ' + 
                'fasta/fastq files contain paired reads. ' +
                "Default: ${params.skesa_use_paired_reads}",
            cliflag: '--use_paired_reads',
            clivalue: (params.skesa_use_paired_reads ?: '')
        ],
        'skesa_kmer': [
            clihelp: "Minimal kmer length for assembly. " +
                "Default: ${params.skesa_kmer}",
            cliflag: '--kmer',
            clivalue: (params.skesa_kmer ?: '')
        ],
        'skesa_min_count': [
            clihelp: 'Minimal count for kmers retained for comparing ' +
                'alternate choices. ' +
                "Default: ${params.skesa_min_count}",
            cliflag: '--min_count',
            clivalue: (params.skesa_min_count ?: '')
        ],
        'skesa_max_kmer': [
            clihelp: 'Maximal kmer length for assembly. ' +
                "Default: ${params.skesa_max_kmer}",
            cliflag: '--max_count',
            clivalue: (params.skesa_max_kmer ?: '')
        ],
        'skesa_max_kmer_count': [
            clihelp: 'Minimum acceptable average count for estimating ' +
                'the maximal kmer length in reads. ' +
                "Default: ${params.skesa_max_kmer_count}",
            cliflag: '--max_kmer_count',
            clivalue: (params.skesa_max_kmer_count ?: '')
        ],
        'skesa_vector_present': [
            clihelp: 'Percentage of reads containing 19-mer for the ' +
                '19-mer to be considered a vector (1. disables). ' +
                "Default: ${params.skesa_vector_present}",
            cliflag: '--vector_present',
            clivalue: (params.skesa_vector_present ?: '')
        ],
        'skesa_insert_size': [
            clihelp: 'Expected insert size for paired reads (if not ' +
                'provided, it will be estimated). ' +
                "Default: ${params.skesa_insert_size}",
            cliflag: '--insert_size',
            clivalue: (params.skesa_insert_size ?: '')
        ],
        'skesa_steps': [
            clihelp: 'Number of assembly iterations from minimal to ' +
                'maximal kmer length in reads. ' +
                "Default: ${params.skesa_steps}",
            cliflag: '--steps',
            clivalue: (params.skesa_steps ?: '')
        ],
        'skesa_fraction': [
            clihelp: 'Maximum noise to signal ratio acceptable for extension. ' +
                "Default: ${params.skesa_fraction}",
            cliflag: '--fraction',
            clivalue: (params.skesa_fraction ?: '')
        ],
        'skesa_max_snp_len': [
            clihelp: 'Maximal SNP length. ' +
                "Default: ${params.skesa_max_snp_len}",
            cliflag: '--max_snp_len',
            clivalue: (params.skesa_max_snp_len ?: '')
        ],
        'skesa_min_contig': [
            clihelp: 'Minimal contig length reported in ouput. ' +
                "Default: ${params.skesa_min_contig}",
            cliflag: '--min_contig',
            clivalue: (params.skesa_min_contig ?: '')
        ],
        'skesa_allow_snps': [
            clihelp: 'Allow additional step for SNP discovery. ' +
                "Default: ${params.skesa_allow_snps}",
            cliflag: '--allow_snps',
            clivalue: (params.skesa_allow_snps ? ' ' : '')
        ]
    ]

    toolspecs.each {
        k, v -> tool.text['--' + k] = "${v.clihelp}"
        tool.helpparams[k] = [ cliflag: "${v.cliflag}", clivalue: v.clivalue ]
    }

    return tool
}