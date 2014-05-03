GLOgen: A plugin for LCA metagenomics
======
GLOgen is a part of a suite of command-line tools meant to help in the analysis of metagenomic sequencing data. 
GLOgen displays "lost" data when carrying out LCA algorithms in metagenomics. Reads which not summarisable at the genus (parameter specifiable) rank in the taxonomic tree can be annotated with the combination of genera it passes through before being LCA-ed.

GLOgen generates for each unique query: 
1. a GLO signature 

Using GLOgen
------
1. Run Rapsearch or any other blast-like annoation software to give tabbed blast output
This generates the sequences annotation against the specified database ie. NR. 

```
prerapsearch -d nr -n nr.rap
Builds suffix tree of database
rapsearch -q query.fa -d nr -o output_file -z <number of threads>
```
NOTE: Use `lscpu` to check the number of cores on machine 

2. Set up Neo4j database
[iomics4j](https://github.com/bowenli37/iomics4j)

3. Run GLOgen.pl
...NOTE: Requires perl v5.10 and above. 
...Usage:


Description 
------
Takes in tablular blast outputs generated from Rapsearch2 (.m8 format)
Example:

```
# RAPSearch
# Job submitted: Tue May  8 17:16:19 2012
# Query : out/mRNA.0000.pieces/b1-0057_s_1.1.fa.aaaa
# Subject : /dev/shm/nr.rap
# Fields: Query Subject identity        aln-len mismatch        gap-openings    q.start q.end   s.start s.end   log(e-value)    bit-score
HWI-ST884:57:1:1101:10716:1994#0/1      gi|383762330|ref|YP_005441312.1|        51.6129 31      14      1       7       96      1121
    1151    -1.18   41.2022
```

Installation 
------

###Databases

* [NR](http://bit.ly/1rV50Tu "nr file")
* [Taxonomy](http://bit.ly/1mjqi9U)

###Tools
* [RAPSearch2](http://omics.informatics.indiana.edu/mg/RAPSearch2/ "Rapsearch2") 

####RAPSearch2 Installation 
#####Prequisites: Requires boost library for installation
* [Boost C++ library](http://www.boost.org/)	

######Boost Installation
...Note you need to install the following libraries:
..* serialization 
..* thread 
..* system 
..* chrono 

```
bootstrap.sh --prefix=$HOME/<path to your installation dir> --libdir=$HOME/local/lib --with-libraries=signals,thread,python,system,serialization,chrono
```

* [NEO4J](http://www.neo4j.org/download)
* [iomics4j](https://github.com/bowenli37/iomics4j)
Stores and organises data for processing


