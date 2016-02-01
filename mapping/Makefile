seq_R1 = $(wildcard *R1*fastq)

all: mapping.sh samview.sh sort.sh index.sh idxstats.sh merge.sh

build_reference.sh:
	PATH=$PATH:~/BT2_HOME
	export PATH
	bowtie2-build reference/each_gene.fa each_gene

mapping.sh:
	export PATH=$PATH:~/BT2_HOME
	for x in $(seq_R1); do echo "bowtie2 -x reference/each_gene.fa -1 $$x -2 $${x%R1*}R2.fastq -S $${x%R1*}.sam 2> $${x%R1*}.out"; done > mapping.sh
	cat mapping.sh | parallel

samview.sh:
	export PATH=~/samtools-1.2:$PATH
	for x in $(seq_R1); do echo "samtools view -Sb $${x%R1*}.sam > $${x%R1*}.bam";done > samview.sh
	cat samview.sh | parallel

sort.sh:
	export PATH=~/samtools-1.2:$PATH
	for x in $(seq_R1); do echo "samtools sort $${x%R1*}.bam $${x%R1*}.sorted";done > sort.sh
        cat sort.sh | parallel
index.sh:
	export PATH=~/samtools-1.2:$PATH
	for x in $(seq_R1); do echo "samtools index $${x%R1*}.sorted.bam";done > index.sh
        cat index.sh | parallel

idxstats.sh:
	export PATH=~/samtools-1.2:$PATH
	for x in $(seq_R1); do echo "samtools idxstats $${x%R1*}.sorted.bam > $${x%R1*}.idxstats.txt";done > idxstats.sh
        cat idxstats.sh | parallel

merge.sh:
	mkdir count
	cp *.idxstats.txt count
	bash idxstatsToOnefile.sh count
