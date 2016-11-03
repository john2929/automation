seq_R1 = $(wildcard *R1*fastq.gz)

all: trim-command.sh interleave-command.sh diginorm-command.sh error-trim.sh extract.sh final-contigs.fa

trim-command.sh: $(seq_R1)
	date >> log
	echo "start trim" >> log 
	for x in $(seq_R1) ;do echo "java -jar /usr/local/bin/trimmomatic-0.30.jar PE $${x%_R1*}_R1_001.fastq.gz $${x%_R1*}_R2_001.fastq.gz $${x%_R1*}_s1_pe $${x%_R1*}_s1_se $${x%_R1*}_s2_pe $${x%_R1*}_s2_se ILLUMINACLIP:/usr/local/share/adapters/TruSeq3-PE.fa:2:30:10 1>$${x%_R1*}.log" ; done > trim-command.sh 
	cat trim-command.sh | parallel
	date >> log
	echo "end trim" >> log

interleave-command.sh: $(seq_R1)
	date >> log
	echo "start interleave" >> log
	for x in $(seq_R1) ; do \
		echo "interleave-reads.py $${x%_R1*}_s?_pe -o $${x%_R1*}interleaved.fastq" ; \
	done > interleave-command.sh
	cat interleave-command.sh | parallel
	date >> log
	echo "end interleave" >> log

diginorm-command.sh: interleave-command.sh
	date >> log
	echo "start diginorm" >> log
	echo "normalize-by-median.py --ksize 20 -R diginorm.report -C 20 --n_tables 4 --max-tablesize 10e9 -p -s normC20k20.kh *interleaved.fastq" > diginorm-command.sh
	bash diginorm-command.sh 
	date >> log
	echo "end diginorm" >> log

error-trim.sh: diginorm-command.sh
	date >> log
	echo "start error-trim" >> log
	echo "filter-abund.py -V normC20k20.kh *keep" > error-trim.sh
	bash error-trim.sh
	date >> log
	echo "end error-trim" >> log

extract.sh: error-trim.sh
	for x in *keep.abundfilt;do echo "extract-paired-reads.py $$x" ;done > extract.sh
	cat extract.sh | parallel

final-contigs.fa:
	date >> log
	echo "start final-contig" >> log
	gzip *abundfilt.pe
	cat *abundfilt.pe*gz > abundfilt-all.gz
	~/megahit/megahit --12 abundfilt-all.gz
	date >> log
	echo "end final-contig" >> log
