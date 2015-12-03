pip install screed
pip install khmer
#trimmomatic
cd /root
curl -O http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.30.zip
unzip Trimmomatic-0.30.zip
cd Trimmomatic-0.30/
cp trimmomatic-0.30.jar /usr/local/bin
cp -r adapters /usr/local/share/adapters

apt-get install libgtextutils-dev
apt-get install fastx-toolkit
apt-get install parallel

cd
git clone https://github.com/voutcn/megahit.git
cd megahit
make