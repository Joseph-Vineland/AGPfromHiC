### Assembling Genomes with Hi-C data and Genetic Maps

The juicer/3d-dna pipeline takes contigs and assembles scaffolds with the help of Hi-C data.  The Chromonomer software take scaffolds and assembles chromosomes with the help of genetic linkage maps.

**Why is this a good strategy for genome assembly?  These software tools will automatically correct assembly errors made during previous steps in a logical fashion.  They prevent you from having to “double back” and repeat previous steps after trying to fix the assembly errors yourself.  It saves loads of time, since it edits your inputs for you.  If your data is good, you will get a high quality, chromosome-level genome assembly with minimal effort.**

In order to carry out this procedure, you need to create AGP file.

This script generates an AGP file from the output of the juicer/3d-dna pipeline.  The resulting AGP file is input to Chromonomer in order to construct a chromosome-level genome assembly.

Usage: `perl mkAgpFileFromHiC.pl <assembly.FINAL.fasta> <assembly.FINAL.assembly>`

I hope it can help you on your genome assembly journey!

#### External Links

Software for assembling scaffolds with Hi-C data:

https://github.com/aidenlab/juicer

https://github.com/aidenlab/3d-dna

Software for building chromosomes with genetic maps:

http://catchenlab.life.illinois.edu/chromonomer/

My blog post on this topic:

https://joseph-vineland.github.io/2022/07/19/Self-Correcting-Genome-Assembly.html
