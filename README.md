# Bogarin Anchored Phylogenomics
Two single purpose scripts used to Blast-search and batch rename the datasets (Fasta) of Bogarin et al. 2018 (in prep)

### Project outline
A dataset consisting of 446 **_fasta_** files (markers) containing 32 reads (taxa) each, needed to be Blast-searched against [GenBank][nBlast]. Blast-searches were run from the command line (using [Blastn 2.6.0])[BlastCmndline] to facilitate batch submission of input files and automatic download (and processing) of output files. Even though Blast-searching against a local database would be much faster, than the remote searches done here, it would also require 

Blast searches were done remotely 

The Blast (nucleotide) database was not downloaded locally

(this would have significantly speed up the searches)

The Blast-search was not done locally against a subset of GenBank (which would significantly speed up the analysis) because the targeted genes were unknown and source DNA had to be validated (in order to rule out contamination). [Blastn 2.6.0][BlastCmndline] was used to facilitate Blast searches from the command line. For each of the 14,472 (theoretical) searches the sequence header (fasta) along with the top five best matching records had to be extracted.

The second part of the project was to adjust the header for each of the reads in the fasta files for submission to GenBank supposedly using tbl2asn2.

Issues encountered:  
 * empty reads for some of the sequences
 * issues with SED on OSX (temporarily solved by using GSED, but unneccary under Unix)






[nBlast]:https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome
[BlastCmndline]:https://www.ncbi.nlm.nih.gov/books/NBK52640/
