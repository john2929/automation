gunzip *.fastq.gz
for file in *.fastq;do echo "paste - - - - < $file | tee >(awk 'BEGIN{FS=\"\t\";OFS=\"\n\"}{if (match(\$1,\" 1:N\"))print \$1,\$2,\$3,\$4}' > $file._R1_001.fastq) | awk 'BEGIN{FS=\"\t\"; OFS=\"\n\"}{if (match(\$1,\" 2:N\"))print \$1,\$2,\$3,\$4}' > $file._R2_001.fastq";done > split-command.sh
cat split-command.sh | parallel
gzip *_R1_001.fastq
gzip *_R2_001.fastq
