# Bogarin Anchored Phylogenomics
Some single purpose scripts used to Blast-search and batch rename the datasets (Fasta) of Bogarin et al. 2018 (in prep)

### Project outline
A dataset consisting of 446 **_fasta_** files (markers) containing 32 reads (taxa) each, needed to be Blast-searched against [GenBank][nBlast]. Blast-searches were run from the command line (using [Blastn 2.6.0][BlastCmndline]) to facilitate batch submission of input files and automatic download (and processing) of output files. Blast searches were done remotely at the NCBI-server; herewith bypassing a local download of the nt-database (~36 Gb compressed) and assuring searches against the most recent database. The downside of this approach is a reduction in speed, but all searches completed in less than a week. We did not search against a subset of taxa (such as Lephales or Orchidaceae) or markers, because we needed to verify the authenticity of the source organisms (check for contamination) and the targeted genes were not known. For each of the 14,472 (theoretical) searches the sequence header (fasta) along with the top ten best matching records had to be extracted. In a number of cases fasta files had empty reads or reads with numerous gaps. Although only the former should be a serious issue, our Blast-script removed both prior to searching.  
The second part of the project was to adjust all fasta headers for submission to GenBank (supposedly) using ["Table to Asn"][tbl2asn] adhering to the "the minimum requirements to generate a Sequin file using tbl2asn"; _one_ **.sbt** file and _one or more_ **.fsa** files.

### Running the ['AutoBlast'][AutoBlast] script and example fasta files
Dependencies:
[Blastn 2.6.0][BlastCmndline] or higher

Once the data are published the full dataset will be available [somewhere][full_dataset]. In the meantime the [mock-dataset][mock] can be used to test the script. Upon execution of [Autoblast][AutoBlast] in the folder containing the fasta files (Autoblast.sh requires input files with a \*.fasta extension) four folders will be created:  
**Query** - contains the original input sequences  
**Cleaned** - contains the cleaned sequences: Blast input files  
**Blast_results** - contains output from the Blast-search in XML format  
**Blast_sum** - contains a summary of Blast_results showing fasta header and the first 10 hits of each read  

### Running the ['Rename'][Rename] script and example description file
No dependencies

This script will work on the same set of fasta files but in addition requires a _descriptions_ file. The latter file (**Description.txt**) is a two column tab separated file (after Bogarin's "Lepanthes NGS Table.xls" < Blast_sum); column one consists of the fasta basename (T272_L1, T272_L2, T272_L3, etc. MS Excel sort descending) and column two of the gene descriptions. For the mock dataset an example of [Description.txt][Description] (also for 5 instead of 446 fasta files) is given. Execution of [Rename.sh][Rename] will yield the folder:    
**Out** - contains the fasta files (\*.fsa) with adjusted headers (adjusted organism field, gene descriptions, failed reads removed)

### Possible improvements
Currently the sequence identifiers (SeqID) are kept unmodified (as obtained from the [Lemmon's pipeline][Lemmon]). The disadvantage of this approach is that for every _n_ th header in each fasta (\*.fsa) output file the SeqIDs are identical. Eventually SeqIDs only function as placeholder until replaced by GenBank accession numbers, so only for interim checks this could be an issue .

### Issues encountered:  
 * empty reads for some of the sequences, causing the search to stall
 * diffences in BSD (as in OSX) and GNU (as in Ubuntu) versions of SED
 * tail -r extension available in OSX not in Ubuntu
 * sort order of the ls command in OSX and Ubuntu not identical

[nBlast]:https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome
[BlastCmndline]:https://www.ncbi.nlm.nih.gov/books/NBK52640/
[tbl2asn]:https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2/
[full_dataset]:https://science.naturalis.nl/en/people/scientists/diego-bogarin/
[mock]:https://github.com/dickgroenenberg/Bogarin_Anchored_Phylogenomics/tree/master/mock_data
[AutoBlast]:https://github.com/dickgroenenberg/Bogarin_Anchored_Phylogenomics/blob/master/scripts/AutoBlast.sh
[Rename]:https://github.com/dickgroenenberg/Bogarin_Anchored_Phylogenomics/blob/master/scripts/Rename.sh
[Description]:https://github.com/dickgroenenberg/Bogarin_Anchored_Phylogenomics/blob/master/mock_data/Description.txt
[Lemmon]:http://anchoredphylogeny.com/workflow/
