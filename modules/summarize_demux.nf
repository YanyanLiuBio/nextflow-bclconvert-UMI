process SUMMARIZE_DEMUX { 

   publishDir path: ".", mode: 'copy'
   
   input:
   path(reports) 

   output:
   path("*.xlsx")

  """
  demux_bclconvert_report.py ${params.plates.replace('.csv', '')}
  """
}