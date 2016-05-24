<cutadapt.mk

CUTADAPT_ADAPTERS=`{for f in `find "$CUTADAPT_ADAPTERDIR" -type f`; do printf -- "-b $f\n"; done}
CUTADAPT_TARGETS=`{find data/ -name '*_R1_001.fastq.gz' | sed 's#^data/#results/cutadapt/#g' }

cutadapt:V: $CUTADAPT_TARGETS

results/cutadapt/%_R1_001.fastq.gz: data/%_R1_001.fastq.gz data/%_R2_001.fastq.gz
	mkdir -p $(dirname $target)
	cutadapt \
		-o results/cutadapt/"$stem"_R1_001.fastq.gz \
		-p results/cutadapt/"$stem"_R2_001.fastq.gz \
		$CUTADAPT_OPTARGS \
		$CUTADAPT_ADAPTERS \
		$prereq

clean:VE:
	rm -r results/cutadapt

%/:
	mkdir -p $stem
