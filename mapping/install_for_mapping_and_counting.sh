#bowtie2
cd ~
wget http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.5/bowtie2-2.2.5-linux-x86_64.zip
unzip bowtie2-2.2.5-linux-x86_64.zip
mv bowtie2-2.2.5 BT2_HOME
cd BT2_HOME/
PATH=$PATH:~/BT2_HOME
export PATH

#samtools
cd ~
wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2
tar xjf samtools-1.2.tar.bz2
cd samtools-1.2
make
export PATH=~/samtools-1.2:$PATH