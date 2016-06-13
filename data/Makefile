NULLGRAPH=~/dev/nullgraph

all: genome.fa.gz reads.fa.gz reads.map.cover mixed-reads.fa.gz

genome.fa.gz:
	$(NULLGRAPH)/make-random-genome.py -s 1 -l 10000 --name='genome' | gzip -9c > genome.fa.gz

reads.fa.gz: genome.fa.gz
	$(NULLGRAPH)/make-reads.py -e .01 -r 100 -C 200 -S 1 genome.fa.gz | gzip -9c > reads.fa.gz

reads.map: reads.fa.gz
	gunzip -c genome.fa.gz > genome.fa
	bowtie2-build genome.fa genome
	gunzip -c reads.fa.gz | bowtie2 genome -f - > reads.map

reads.map.cover: reads.map
	./sam-calc-refcov.py genome.fa.gz reads.map > reads.map.cover

mixed-species.fa.gz:
	$(NULLGRAPH)/make-random-genome.py -s 2 -l 5000 --name='spA 3' > mixed-species.fa
	$(NULLGRAPH)/make-random-genome.py -s 3 -l 5000 --name='spB 2' >> mixed-species.fa
	gzip mixed-species.fa

mixed-reads.fa.gz: mixed-species.fa.gz
	$(NULLGRAPH)/make-biased-reads.py -e .01 -r 100 -C 100 -S 1 mixed-species.fa.gz | gzip -9c > mixed-reads.fa.gz
