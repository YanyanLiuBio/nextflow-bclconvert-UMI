#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { BCLCONVERT } from './modules/bclconvert.nf'
include { SUMMARIZE_DEMUX } from './modules/summarize_demux.nf'


workflow {


    Channel
        .fromPath(params.bcl_dir)
        .set { bcl_ch }

    Channel
        .fromPath(params.samplesheet)
        .set { samplesheet_ch }

    BCLCONVERT(
        bcl_ch,
        samplesheet_ch
    )


    SUMMARIZE_DEMUX(
        BCLCONVERT.out.report.collect()
    )
}
