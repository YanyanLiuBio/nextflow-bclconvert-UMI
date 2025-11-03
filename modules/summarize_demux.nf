process SUMMARIZE_DEMUX { 

   publishDir path: ".", mode: 'copy'
   
   input:
   path(reports) 

   output:
   path("*.xlsx")

  """
  sample=\$(basename ${params.samplesheet} .csv)
  demux_bclconvert_report.py \$sample
  """
}