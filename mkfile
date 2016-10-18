<trimmomatic.mk

TRIMMOMATIC_ADAPTERS=`{find -L "$TRIMMOMATIC_ADAPTERDIR" -type f -name *.fasta}
TRIMMOMATIC_TARGETS=`{find -L data/ -name '*_R1.fastq.gz' | sed 's#^data/#results/trimmomatic/paired/#g' }

trimmomatic:V: $TRIMMOMATIC_TARGETS

results/trimmomatic/paired/%_R1.fastq.gz	\
results/trimmomatic/unpaired/%_R1.fastq.gz	\
results/trimmomatic/paired/%_R2.fastq.gz	\
results/trimmomatic/unpaired/%_R2.fastq.gz	\
:	data/%_R1.fastq.gz	data/%_R2.fastq.gz
	mkdir -p results/trimmomatic/paired/$(dirname $stem)
	mkdir -p results/trimmomatic/unpaired/$(dirname $stem)
	mkdir -p results/trimmomatic/log/$(dirname $stem)
	trimmomatic \
		PE \
		$prereq \
		"results/trimmomatic/paired/"$stem"_R1.fastq.gz"	\
		"results/trimmomatic/unpaired/"$stem"_R1.fastq.gz"	\
		"results/trimmomatic/paired/"$stem"_R2.fastq.gz"	\
		"results/trimmomatic/unpaired/"$stem"_R2.fastq.gz"	\
		-trimlog "results/trimmomatic/log/"$stem".log" \
		$TRIMMOMATIC_OPTARGS \
		ILLUMINACLIP:$TRIMMOMATIC_ADAPTERS:2:30:10 \
		LEADING:3 \
		TRAILING:3 \
		AVGQUAL:18

clean-trimmomatic:VE:
	rm -r results/trimmomatic
