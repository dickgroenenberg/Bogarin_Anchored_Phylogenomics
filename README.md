# Bogarin Anchored Phylogenomics
Some single purpose scripts used to Blast-search and batch rename the datasets (Fasta) of Bogarin et al. 2018 (in prep)

### Project outline
A dataset consisting of 446 **_fasta_** files (markers) containing 32 reads (taxa) each, needed to be Blast-searched against [GenBank][nBlast]. Blast-searches were run from the command line (using [Blastn 2.6.0])[BlastCmndline] to facilitate batch submission of input files and automatic download (and processing) of output files. Blast searches were done remotely at the ncbi-server; herewith bypassing the download of the nt-database (~36 Gb compressed) and assuring searches against the most recent database. The downside of this approach is a likely reduction in speed, but all searches completed in less than a week. We did not search against a subset of taxa (such as Lephales or Orchidaceae), nor against a subset of markers, because source DNA needed to be validated (verify authenticity) and the targeted genes were unknown. For each of the 14,472 (theoretical) searches the sequence header (fasta) along with the top five best matching records had to be extracted. In a number of cases fasta files had empty reads or reads with numerous gaps. Although only the former should be a serious issue, our Blast-script removed both prior to searching.



The second part of the project was to adjust the header for each read in every fasta file  for submission to GenBank supposedly using tbl2asn2.

Issues encountered:  
 * empty reads for some of the sequences
 * issues with SED on OSX (temporarily solved by using GSED, but unneccary under Unix)






[nBlast]:https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome
[BlastCmndline]:https://www.ncbi.nlm.nih.gov/books/NBK52640/
