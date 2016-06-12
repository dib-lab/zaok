NULLGRAPH=~/dev/nullgraph

all: genome.fa.gz reads.fa.gz

genome.fa.gz:
	$(NULLGRAPH)/make-random-genome.py -s 1 -l 1000 --name='genome' | gzip -9c > genome.fa.gz

reads.fa.gz: genome.fa.gz
	$(NULLGRAPH)/make-reads.py -e .01 -r 150 -C 100 -S 1 genome.fa.gz | gzip -9c > reads.fa.gz
