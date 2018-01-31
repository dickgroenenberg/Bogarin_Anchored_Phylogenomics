# Creation of Mock datasets:

Until formally published there will be an embargo on the data of Bogarin et al. 2018 (in prep).
To test the scripts of this Github repository a small mock dataset is created.

The mock dataset is realistic without exposing much information. It consists of 5 fasta-files
(each representing 4 unique sequences; the size being identical to the original files, n = 32).
To anonymise these sequences the organism identifiers in the sequence headers were replaced.
In total the mock dataset represents less than 0.14 % of the data (20/14,472).

For sake of completeness, below a summary of how the mock datasets were created.

### Original **Fasta** files (T272_L[1-5].fasta):
T272_L1.fasta
T272_L2.fasta
T272_L3.fasta
T272_L4.fasta
T272_L5.fasta

### Extract Fasta headers (create **Headers.txt**)
Fasta headers are identical for each of the 446 datasets.
Extract headers, remove identfication (the part between Orchidaceae..seq) and save to a file named **Headers.txt**. Ensure **_sed_** is called with -E (or -r) option to allow extended regular expressions.
```bash
egrep "^>" T272_L1.fasta | sed -E's/_Orchidaceae_.*?_seq/_Orchidaceae_Mockus_mockus_seq/g' > Headers.txt
```

### Add identifiers (A1,A2,B1,B2 .. P1,P2) to headers
Manually edit **Headers.txt**
```
>I20394_DB01_Asparagales_Orchidaceae_Mockus_mockus_seq1 --> >I20394_DB01_Asparagales_Orchidaceae_Mock_mockus_A1_seq1
>I20394_DB01_Asparagales_Orchidaceae_Mockus_mockus_seq2 --> >I20394_DB01_Asparagales_Orchidaceae_Mock_mockus_A2_seq2
etc.
```
### Extract sequences (create **L[1-5].seqs.txt**)
Inverted **grep** to remove sequence headers
```bash
egrep -v "^>" T272_L1.fasta > L1.seqs.txt
egrep -v "^>" T272_L2.fasta > L2.seqs.txt
etc.
```
### Select exemplar sequences (create **L[1-5].mock.seqs.txt**)
Mannually reduce each file from previous step (L[1-5].seqs.txt) to four sequences and 
muliply those eight times (so the size of the datasets remains identical) and save as:
```
L1.mock.seqs.txt
L2.mock.seqs.txt
etc.
```
### Create a new folder for mock-data
```bash
mkdir mock
```

### Create mock datasets (**T272_L[1-5].fasta**)
Merge header (**Headers.txt**) and mock sequences (**L[1-5].mock.seqs.txt**)
```bash
paste -d '\n' Headers.txt L1.mock.seqs.txt > mock\T272_L1.fasta
paste -d '\n' Headers.txt L2.mock.seqs.txt > mock\T272_L2.fasta
etc.
```