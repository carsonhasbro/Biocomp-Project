# Aligns sequences for proteomes to determine the presence of the McrA gene as well as the presence of a number of copies of the HSP70 gene for each proteome

# The script then determines a list of the best proteomes to culture based on presence of the McrA gene and the quantity of HSP70 genes present

# Usage: bash analysis.sh mcrAgeneimage.fasta hsp70geneimage.fasta proteome*

# Use when within the protomes subdirectory in Biocomp-project directory

# Files "mcrAgeneimage.fasta" and "hsp70geneimage.fasta" are concatenated lists of all reference sequences of interest for each respective gene from the ref_sequences subdirectory within the Biocomp-project directory 

# Step 1: create a search image for the mcrA and HSP70 genes by aligning the sequences using MUSCLE and then building a HMM profile for each

# Step 2: search for both genes within each proteome to find matches within the proteomes

# Step 3: count matches for both genes within each proteome

# Step 4: recommend model organisms to move forwards with culturing

# Step 1:

muscle -in "$1" -out mcrAgeneimage.afasta
hmmbuild mcrAgeneimage.hmm mcrAgeneimage.afasta
muscle -in "$2" -out hsp70geneimage.afasta
hmmbuild hsp70geneimage.hmm hsp70geneimage.afasta

# Step 2:

for file in "$@"
do
echo $file
hmmsearch mcrAgeneimage.hmm $file
done

# ignore the first two results for this table, as they are the lists of reference sequences, not the proteome genomes

# Step 3:

# When counting the organisms that can make methane, we can eliminate most of the proteomes from our possible recommendation.
# These organisms include proteomes 01, 02, 04, 06, 08, 09, 10, 11, 12, 13, 14, 17, 18, 20, 21, 22, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 40, 41, 43, 46, 47, and 49
# By eliminating these proteomes, we are left to analyze only 16 more for their pH resistance using the HSP70 gene
# These include proteomes 03, 05, 07, 15, 16, 19, 23, 24, 29, 38, 39, 42, 44, 45, 48, and 50

# Step 2 (cont.):

for file in "$@"
do
echo $file
hmmsearch hsp70geneimage.hmm $file
done

# ignore the first two results for this table, as they are the lists of reference sequences, not the proteome genomes

# Step 3 (cont.):

# When counting the number of instances with the REMAINING proteomes (not all because we only care about the proteomes that produce methane),
# we can see that the average number of HSP70 genes for an organism to have is 1.6875, with the median being 1.5.

# The full list for reference is:
# proteome 03: 3 HSP70 genes
# proteome 05: 2 HSP70 genes
# proteome 07: 2 HSP70 genes
# proteome 15: 1 HSP70 genes
# proteome 16: 1 HSP70 genes
# proteome 19: 1 HSP70 genes
# proteome 23: 2 HSP70 genes
# proteome 24: 2 HSP70 genes
# proteome 29: 0 HSP70 genes
# proteome 38: 1 HSP70 genes
# proteome 39: 1 HSP70 genes
# proteome 42: 3 HSP70 genes
# proteome 44: 1 HSP70 genes
# proteome 45: 3 HSP70 genes
# proteome 48: 1 HSP70 genes
# proteome 50: 3 HSP70 genes

# Step 4:

# Given these results, the proteomes that are especially resistant to pH would include proteomes 03, 42, 45, and 50, with proteomes 05, 07, 23, and 24 being above the average
# I would suggest that proteomes 03, 42, 45, and 50 definitely be considered for further research, as they produce methane and have 3 genes that help with pH resistance
# I would also recommend that proteomes 05, 07, 23, and 24 be considered for further research if more individuals are desired, as they all have 2 genes that help with pH resistance and all produce methane as well.
