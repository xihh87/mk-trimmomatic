This is a module for a bioinformatic pipeline using mk

# Requirements

- mk (usually on 9base or plan9port package)
- [cutadapt](http://code.google.com/p/cutadapt/ )

# How to use

There should be a data directory including at least one fastq or fastq.gz file
and an `adapters` directory containing the adapters used,
for example:

```
$ find data -name '*.fastq*'
data/150819_10Beta-28341426/10BetaS6_ALL_R2.fastq
data/150819_10Beta-28341426/10BetaS6_ALL_R1.fastq.gz
$ find adapters -name '*.fastq'

```

You can optionally set an alternate directory for your adapters (by default `adapters/`):
and extra parameters for the execution of cutadapt (none by default)
by modifying `cutadapt.mk`.

Then run the following command:

```
$ mk
```

There! mk should do everything needed to take out your adapters.

Your adapter-cropped files will be on `results/cutadapt` when the process ends.
