#!/bin/bash

# dependencies: blastn: 2.6.0+
#
# Loops through all fasta files in the folder from where this script is initiated
# and performs a remote Blast-search on the NCBI server for each of these files.
# Input files should have the extensino 'fasta'
# After this script has finished the following folders will be created:
#	"Query" 		(the original fasta files)
#	"Cleaned"		(fasta files without empty reads or indels: Blast input)
#	"Blast_results"		(output from Blast-search in XML format: outfmt 5)
#	"Blast_sum"		(summary containing first ten hits for each fasta header)
#
# usage: ./AutoBlast.sh
#
# author: D.S.J. Groenenberg
# company: Naturalis Biodiversity Center

T="$(date +%s)"
mkdir Query Cleaned Blast_results Blast_sum

#---"Data cleaning"----------------------------------------------------------------------------
# Remove indels "-" from fasta files
# Remove failed reads from fasta
# The fancy sed command searches for lines containing only n (ie. ^n$) and removes
# that line and the line before.

mv *.fasta Query/

cd Query

for i in *.fasta
do
	tr -d "-" < $i | sed -n '/^n$/{s/.*//;x;d;};x;p;${x;p;}' | sed '/^$/d' > ../Cleaned/"$i"
done

#---"Blast cleaned sequences"----------------------------------------------------------------------------

cd ../Cleaned

for i in *.fasta
do
	blastn -task blastn -db nt -query $i -max_target_seqs 10 -out ../Blast_results/"$i".blast -remote -outfmt 5
done

cd ../Blast_results

for i in *.blast
do 
	egrep "<Iteration_query-def>|<Hit_def>" $i | tr ">" "<" | awk -F"<" '{print$3}' | sed 's/^I20/\nI20/g' > ../Blast_sum/"$i".sum.txt
done

T="$(($(date +%s)-T))"
printf "Blast-search completed in: %02d hrs %02d min %02d sec\n" "$((T/3600%24))" "$((T/60%60))" "$((T%60))"
