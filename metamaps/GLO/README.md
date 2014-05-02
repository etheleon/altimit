Introduction 
======


GLOgen generates for each unique query: 
1. a GLO signature 

Takes in tablular blast outputs. 


Installation 
------

###Databases

* [NR](ftp://lucid.bic.nus.edu.sg/biomirrors/blast/db/FASTA/nr.gz "nr file")
* [Taxonomy](ftp://lucid.bic.nus.edu.sg/biomirrors/taxonomy/ncbi/gi_taxid_prot.dmp.gz)

###Tools
* [RAPSearch2](http://omics.informatics.indiana.edu/mg/RAPSearch2/ "Rapsearch2") 

Generates tabluar blast output required for GLOgen
Example Blast .m8 output from Rapsearch2
```
# RAPSearch
# Job submitted: Tue May  8 17:16:19 2012
# Query : out/mRNA.0000.pieces/b1-0057_s_1.1.fa.aaaa
# Subject : /dev/shm/nr.rap
# Fields: Query Subject identity        aln-len mismatch        gap-openings    q.start q.end   s.start s.end   log(e-value)    bit-score
HWI-ST884:57:1:1101:10716:1994#0/1      gi|383762330|ref|YP_005441312.1|        51.6129 31      14      1       7       96      1121
    1151    -1.18   41.2022
```

* [NEO4J](http://www.neo4j.org/download)
* [iomics4j](https://github.com/bowenli37/iomics4j)
Stores and organises data for processing


