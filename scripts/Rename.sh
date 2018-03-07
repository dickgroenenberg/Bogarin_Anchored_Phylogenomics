#!/bin/bash

# This script renames the header of each sequence (32) in a set of fasta files (446), 
# to add marker descriptions (Description.txt) and adjusts headers to be better in line [*]
# with GenBank submission format.
# [*] No validity checks on the description lines! This script doesn't check naming conventions
# described in: https://www.ncbi.nlm.nih.gov/genbank/genomesubmit_annotation/
# Neither does it check sequence validity (e.g. )
#
# Script outline:
# Sort Description.txt, create Descriptions_file [B]
# Create files for Header [A], Separator [C] and Sequence [D]
# Merge [A][B][C][D] for all reads (32) in each fasta (446) and replace [C] with line break
# Clean sequencens (remove indels and failed reads).
# Write output to 'Out' folder.
# Remove temporary files.
#
#
# usage: ./Rename_sed.sh
# requires: Description.txt fasta files (T272_L1.fasta .. T272_L446.fasta)
# output: "Out" folder containing fasta (*.fsa) files with renamed headers and "cleaned" sequences	
#
# author: D.S.J. Groenenberg
# company: Naturalis Biodiversity Center

mkdir Out

# --- Create truncs of fasta files and split sequences and headers ----------------------------------

# truncated name of fasta as variable (a list)
truncate=$(ls *.fasta | sed 's/\.fasta//g')

# Separate Headers and Sequences; adjust Headers 
for i in *.fasta; do
	# truncate unique name fasta
		newname="$(echo "$i" | sed 's/.\{6\}$//')"
	# separate and adjust headers using truncated name
		egrep "^>" "$i" | sed 's/_Asparagales_Orchidaceae_/ [organism=/g' | sed 's/_seq\(1\|2\)/]/g' |
		sed -E 's/(\[organism=.*)_/\1 /g' > "$newname".header
	# separate sequences using truncated name
		egrep -v "^>" "$i" > "$newname".sequence
done

# --- Multiply Description and Separator files ------------------------------------------------------------

# Sort and Mulitply Description file
# Add .fasta extension to first column, sort (order is now identical to original fasta files), 
# multiply each line 32 times, write output to file
# Warning: Descriptions are taken 'as is' - no validity checks!
awk -F"\t" 'OFS="\t"{$1=$1".fasta"}1' Description.txt | sort | awk '{for(i=0;i<32;i++)print}' > Desc_sort.txt

# Create .desc file for each .fasta
# Change .fasta in _fasta in first column (this prevents error when setting field separator in awk) 
# and remove tab between $1 and $2; keep existing order (don't sort!)
# Export $2 using the name of $1 (add ".desc" extension) using "_fasta" as separator
tr -d "\t" < Desc_sort.txt | sed 's/\.fasta/_fasta/g'| awk -F"_fasta" '{print $2 > $1".desc"}'

# create and multiply separator file
for i in {1..32}; do 
	echo "--SePaRaToR--" >> Separator.txt
done

# --- Merge files on base-name (truncate) and write output to Out ------------------------------------------------------------

# Merge Header[A], Description[B], Separator[C] and Sequence[D]; Replace Separator[D] with line breaks ("\n")
# The third sed command removes gaps(-) from sequences (i.e. lines not starting with ">")
# The fourth fancy sed command searches for lines containing only n (ie. ^n$) and removes those 
# and the header before.

for i in $truncate; do
	paste "$i".header "$i".desc Separator.txt "$i".sequence | 
	tr -d "\t" | sed 's/]/] /g' | sed 's/--SePaRaToR--/\n/g'|
	sed '/^>/!s/-//g' | sed -n '/^n$/{s/.*//;x;d;};x;p;${x;p;}' | sed '/^$/d' > Out/"$i".fsa
done

# --- Clean up: so you saw it, now you don't ------------------------------------------------------------
rm -r *.header *.desc *.sequence Separator.txt Desc_sort.txt

