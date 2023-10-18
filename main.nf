#!/usr/bin/env nextflow

// Using DSL-2
nextflow.enable.dsl=2

process nextstrain {
    publishDir "${params.output}", mode: 'copy', overwrite: true
    cpus params.cpus
    memory "${params.memory_gb}.GB"
    container "${params.container}"

    input:
        path "custom.sequences.fasta"
        path "custom.metadata.tsv"
        path "configfile.yaml"
        path "auspice-config.json"

    output:
        path "*/data", emit: data
        path "*/results", emit: results
        path "*/auspice", emit: auspice

    script:
    template "nextstrain.sh"
}

workflow {

    // Log the inputs
    log.info"""Nextstrain Build

Parameters:

    workflow:       ${params.workflow}
    sequences:      ${params.sequences}
    metadata:       ${params.metadata}
    configfile:     ${params.configfile}
    auspice:        ${params.auspice}
    output:         ${params.output}

Runtime:

    cpus:           ${params.cpus}
    memory_gb:      ${params.memory_gb}
    container:      ${params.container}

    """

    // Check for params
    if(!params.workflow){error "Must provide --workflow"}
    if(!params.sequences){error "Must provide --sequences"}
    if(!params.metadata){error "Must provide --metadata"}
    if(!params.configfile){error "Must provide --configfile"}
    if(!params.auspice){error "Must provide --auspice"}
    if(!params.output){error "Must provide --output"}

    // Point to the files
    sequences = file(params.sequences, checkIfExists: true)
    metadata = file(params.metadata, checkIfExists: true)
    configfile = file(params.configfile, checkIfExists: true)
    auspice = file(params.auspice, checkIfExists: true)

    // Run the build
    nextstrain(
        sequences,
        metadata,
        configfile,
        auspice
    )

}