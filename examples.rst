=============
Some examples
=============

Extracting unassembled reads
============================

If we want to extract unassembled reads, we can do the following:

* load the reads in & tag them;
* load the assembly in and label all the matching tags;
* walk over the reads and extract any read that doesn't have an unlabeled
  tag.

This is implemented in the khmer script
``sandbox/extract-unassembled-reads.py``.
  
----

We probably want to work with low-error reads, so, first pre-process the
reads to eliminate errors::
  
   trim-low-abund.py -C 5 -Z 20 -M 1e7 data/mixed-reads.fa.gz
   
Then, run ``extract-unassembled-reads.py``; here, we'll run it with an
"assembly" that is missing the low-abundance genome (1/10th of the data). ::
  
   ../khmer/sandbox/extract-unassembled-reads.py data/mixed-species-1.fa.gz mixed-reads.fa.gz.abundtrim
   # output: 1116 left out of assembly, of 4286 reads

In this case (simulated data) we get 0 reads if we use the true genome::

   ../khmer/sandbox/extract-unassembled-reads.py data/mixed-species.fa.gz mixed-reads.fa.gz.abundtrim
   # output: 0 left out of assembly, of 4286 reads

If we use the un-trimmed reads, then a bunch of reads don't match b/c of
errors::
  
   sandbox/extract-unassembled-reads.py data/mixed-species.fa.gz data/mixed-reads.fa.gz
   # output: 568 left out of assembly, of 5508 reads

Characterizing the unassembled reads
------------------------------------

Next steps could include:

* running extract-compact-dbg.py on it & visualizing it;
* partitioning & examining the partitions;
* looking at the abundance distribution of the whole thing, or each
  individual partition;
