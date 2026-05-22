#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

process SHOW_INPUTS {
    debug true

    input:
    path samplesheet
    path reference_bed
    path input_dir

    output:
    path "report.txt"

    script:
    """
    {
      echo "=== samplesheet ==="
      cat ${samplesheet}
      echo
      echo "=== reference_bed ==="
      head -n 5 ${reference_bed}
      echo
      echo "=== input_dir listing ==="
      ls -la ${input_dir}
    } | tee report.txt
    """
}

workflow {
    log.info "params.samplesheet   = ${params.samplesheet}"
    log.info "params.reference_bed = ${params.reference_bed}"
    log.info "params.input_dir     = ${params.input_dir}"
    log.info "projectDir           = ${projectDir}"
    log.info "launchDir            = ${launchDir}"

    SHOW_INPUTS(
        file(params.samplesheet, checkIfExists: true),
        file(params.reference_bed, checkIfExists: true),
        file(params.input_dir, checkIfExists: true, type: 'dir')
    )
}
