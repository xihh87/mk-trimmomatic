<config.mk
FILES=`{find "$DATA_DIR/" -name '*.fastq.gz'}

ADAPTERS=`{for f in `find "$ADAPTERS_DIR" -type f`; do printf -- "-b $f\n"; done}

CUTADAPT_TARGETS=`{find "$DATA_DIR/" -name '*_R1_001.fastq.gz'}
CUTADAPT_TARGETS=`{for f in $CUTADAPT_TARGETS; do echo "$RESULTS_DIR/cutadapt/${f#$DATA_DIR/}"; done}

cutadapt:V: $CUTADAPT_TARGETS

results/cutadapt/%_R1_001.fastq.gz: data/%_R1_001.fastq.gz data/%_R2_001.fastq.gz
	mkdir -p $(dirname $target)
	cutadapt \
		-o results/cutadapt/"$stem"_R1_001.fastq.gz \
		-p results/cutadapt/"$stem"_R2_001.fastq.gz \
		$ADAPTERS \
		$prereq

init:VN: $DATA_DIR/ $RESULTS_DIR/cutadapt/ config.mk

config.mk:
	cp config.mk.example config.mk

clean:VE:
	rm -r $RESULTS_DIR/cutadapt

%/:
	mkdir -p $stem
