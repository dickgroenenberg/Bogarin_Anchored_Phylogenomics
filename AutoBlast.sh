#!/bin/bash

# dependencies: blastn: 2.6.0+
#
# loops through subfolder named "Query" and blasts all fasta files in it
# fasta files should have the extension 'fasta'
# results are written to 'Blast_results'
# output format is XML (outfmt 5)
# only the first 10 hits are kept
#
# Based on 'Blast_results' a subfolder 'Blast_sum' will be created
# containing an excerpt of fasta_headers and full_description lines
#
# usage: ./AutoBlast.sh
#
# author: D.S.J. Groenenberg
# company: Naturalis Biodiversity Center

mkdir Blast_results Blast_sum
cd Query

for i in *.fasta
	do blastn -task blastn -db nt -query $i -max_target_seqs 10 -out ../Blast_results/"$i".blast -remote -outfmt 5
done

cd ../Blast_results

for i in *.blast
	do egrep "<Iteration_query-def>|<Hit_def>" $i | tr ">" "<" | awk -F"<" '{print$3}' | sed 's/^I20/\nI20/g' > ../Blast_sum/"$i".sum.txt
done
