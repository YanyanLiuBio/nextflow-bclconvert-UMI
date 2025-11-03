process BCLCONVERT {

     input:
     path(bcl) 
     path(samplesheet) 

     output:
     path("*")
     path("Reports"), emit: report
     path("*FASTQ")    

     publishDir path: ".", mode: 'copy'
     
     """
     bcl-convert \
        --bcl-input-directory $bcl \
        --output-directory . \
        --bcl-sampleproject-subdirectories true \
        --force \
        --sample-sheet ${samplesheet} 
         
     chmod -R u+rwX,go+rX ./*FASTQ 2>/dev/null || true 
     
     # Process fastq files that are already in *_FASTQ directories
     for dir in *_FASTQ; do
         if [ -d "\$dir" ]; then
             cd "\$dir"
             ls *.fastq.gz 2>/dev/null > fq_list.txt || continue
             
             while read fq; do
                 fname=\$(basename "\$fq" .fastq.gz)
                 
                 if [[ "\$fname" =~ ^[A-H][0-9]{2}_S[0-9]{1,3}_ ]]; then
                     newname=\$(echo "\$fname" | sed -E 's/_S[0-9]{1,3}_L001//')
                     mv "\$fq" "\${newname}.fastq.gz"
                 else
                     echo "Skipping file (no match): \$fname"
                 fi
             done < fq_list.txt
             
             rm fq_list.txt
             cd ..
         fi
     done

     """
}
