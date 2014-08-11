#!/usr/bin/env perl 

use strict;
use v5.10;
use autodie;
use REST::Neo4p;
use REST::Neo4p::Query;

die "usage: treebuilder.pl <m8-graph-1 output> <neo4j server address>\n" unless $#ARGV==1;

REST::Neo4p->connect($ARGV[1]);

my %basetaxahash;

open my $IN, $ARGV[0];
LINE:while(<$IN>) { 
if($. != 1) { #Skips header
    chomp;
    my ($read, $gi, $basetaxa, $bitscore)  = split /\t/;
    next LINE if $basetaxa =="";
    unless (exists $basetaxahash{$basetaxa}) {
    $basetaxahash{$basetaxa}=$basetaxa;
    	}
    }
}
say ('#',scalar keys %basetaxahash, " basetaxa are all stored in hash.\n#Now querying database");

#Builds query statement
#my $stmt='start basetaxa=node:ncbitaxid(taxid={taxids}) match basetaxa-[:childof*]->(rank:`',$rank,'`) return genus.taxid';
#my $stmt='start basetaxa=node:ncbitaxid(taxid={taxids}) match basetaxa-[:childof*]->(genus:`genus`)-[:childof*]->(family:`family`)-[:childof*]->(order:`order`)-[:childof*]->(class:`class`)-[:childof*]->(phylum:`phylum`) return genus.taxid,family.taxid,order.taxid,class.taxid,phylum.taxid';
my $stmt = <<EOF;
START basetaxa=node:ncbitaxid(taxid={taxids}) 
MATCH basetaxa-[:childof*0..]->(higher) 
WHERE higher:genus OR higher:family OR higher:order OR higher:class OR higher:phylum 
RETURN labels(higher), higher.taxid
EOF

my @ranks = qw/genus family order class phylum/;

#build Hash: Round2
foreach my $basetaxa (keys %basetaxahash) {
    my %rankhash;
	my $query = REST::Neo4p::Query->new($stmt,{ taxids => $basetaxa });
	$query->execute;
	while (my $row = $query->fetch) {
	    foreach (@{$row->[0]}) {		#this column has multiple items hence its an array
	    	if (!/Taxon/){			#there's labels called "Taxon"
	    	    $rankhash{$_} = $row->[1];	#rank :: taxid
	    	}
	}
    }
    my @tree;			#for storing the taxastring
    push(@tree, $basetaxa);
    foreach (@ranks) { 
    	if(exists $rankhash{$_}){push(@tree, "$rankhash{$_}")}else{push(@tree,"NA")}
    }
    $basetaxahash{$basetaxa} = join("_" , @tree);
}
#	foreach(keys %basetaxahash) {say "$_\t$basetaxahash{$_}"}
close $IN;
open my $IN, $ARGV[0];
while(<$IN>){
    chomp;
    my ($read, $gi, $basetaxa, $bitscore)  = split /\t/;
    if ($. == 1){
    	say "$_\tTREE";
    }else{
    	say "$_\t$basetaxahash{$basetaxa}";
    }
}
close $IN; 
