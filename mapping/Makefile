seq_R1 = $(wildcard *R1*fastq)

all: mapping.sh samview.sh sort.sh index.sh idxstats.sh merge.sh

build_reference.sh:
	PATH=$PATH:~/BT2_HOME
	export PATH
	bowtie2-build reference/each_gene.fa each_gene

mapping.sh:
	PATH=$PATH:~/BT2_HOME
	for x in $(seq_R1); do echo "bowtie2 -x reference/each_gene.fa -1 $$x -2 $${x%R1*}R2.fastq -S $${x%R1*}.sam 2> $${x%R1*}.out"; done > mapping.sh
	cat mapping.sh | parallel

samview.sh:

sort.sh:

index.sh:

idxstats.sh:

merge.sh: