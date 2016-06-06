<trimmomatic.mk

TRIMMOMATIC_ADAPTERS=`{for f in `find "$TRIMMOMATIC_ADAPTERDIR" -type f`; do printf -- "-b $f\n"; done}
TRIMMOMATIC_TARGETS=`{find data/ -name '*_R1_001.fastq.gz' | sed 's#^data/#results/trimmomatic/#g' }

trimmomatic:V: $TRIMMOMATIC_TARGETS

results/trimmomatic/paired/%_R1_001.fastq.gz	\
results/trimmomatic/unpaired/%_R1_001.fastq.gz	\
results/trimmomatic/paired/%_R2_001.fastq.gz	\
results/trimmomatic/unpaired/%_R2_001.fastq.gz	\
:	data/%_R1_001.fastq.gz data/%_R2_001.fastq.gz
	mkdir -p $(dirname $target)
	trimmomatic \
		PE \
		$prereq \
		$target \
		$TRIMMOMATIC_OPTARGS \
		ILLUMINACLIP:TRIMMOMATIC_ADAPTERS:2:30:10

clean-trimmomatic:VE:
	rm -r results/trimmomatic
