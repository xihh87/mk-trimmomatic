<config.mk

'results/%_R1.paired.fastq.gz' \
'results/%_R1.unpaired.fastq.gz' \
'results/%_R2.paired.fastq.gz' \
'results/%_R2.unpaired.fastq.gz' \
: 'data/%_R1_001.fastq.gz' 'data/%_R2_001.fastq.gz'
	mkdir -p $(dirname $target)
	set -x
	trimmomatic \
		PE \
		$TRIMMOMATIC_OPTARGS \
		-trimlog "results/log/"$stem".log" \
		$prereq \
		'results/'$stem'_R1.paired.build.fastq.gz' \
		'results/'$stem'_R1.unpaired.build.fastq.gz' \
		'results/'$stem'_R2.paired.build.fastq.gz' \
		'results/'$stem'_R2.unpaired.build.fastq.gz' \
		$TRIMMOMATIC_ANALYSIS \
	&& {
		mv 'results/'$stem'_R1.paired.build.fastq.gz' 'results/'$stem'_R1.paired.fastq.gz' \
		mv 'results/'$stem'_R1.unpaired.build.fastq.gz' 'results/'$stem'_R1.unpaired.fastq.gz' \
		mv 'results/'$stem'_R2.paired.build.fastq.gz' 'results/'$stem'_R2.paired.fastq.gz' \
		mv 'results/'$stem'_R2.unpaired.build.fastq.gz' 'results/'$stem'_R2.unpaired.fastq.gz' \
	}

'results/%.fastq.gz':	'data/%.fastq.gz'
	mkdir -p $(dirname $target)
	set -x
	trimmomatic \
		SE \
		$TRIMMOMATIC_OPTARGS \
		-trimlog "results/log/"$stem".log" \
		$prereq \
		'results/'$stem'.build.fastq.gz' \
		$TRIMMOMATIC_ANALYSIS \
	&& mv 'results/'$stem'.build.fastq.gz' 'results/'$stem'.fastq.gz'

clean:VE:
	rm -rf results/
